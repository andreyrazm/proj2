
class PersonController < ApplicationController
  helper_method :sort_column, :sort_direction, :parse_wmid

  def index
     params[:sort] ||= 'name'
    # Проверка надо ли добавить wmid или кошелёк
    if params[:new]!=nil and params[:new].size==12
      parse_wmid('<request><wmid>' + params[:new] + '</wmid></request>')
      params[:new]=nil
    elsif params[:new]!=nil and params[:new].size==13
      parse_wmid('<request><purse>' + params[:new] + '</purse></request>')
    end

    @persons = Person.search(params).order(sort_column + ' ' + sort_direction).paginate(per_page: 8, page: params[:page])
    @att=Attestate.all

  end

  def destroy
    Person.find(params[:id]).destroy
    redirect_to :action => 'index'
  end




  private
    def parse_wmid(z)

    res=RestClient.post 'https://passport.webmoney.ru/xml/XMLGetWMIDInfo.aspx', z
    xm = Nokogiri::XML(res)

    if xm.root.at_xpath('error')!=nil
      return
    end
    att=xm.root.at_xpath('certinfo/attestat/row')['typename']
    @test=xm.root.at_xpath('certinfo/attestat/row')['typename']

    if Attestate.where('attname LIKE ?', "%#{att}%").empty?
       Attestate.create(attname: att)
    end

    x=Attestate.where('attname LIKE ?', "%#{att}%")
    attestate_id=x.first.id
    wmid=xm.root.at_xpath('certinfo/wmids/row')['wmid']
    lvl=xm.root.at_xpath('certinfo/wmids/row')['level']
    date= xm.root.at_xpath('certinfo/wmids/row')['datereg']
    name =xm.root.at_xpath('certinfo/userinfo/value/row')['fname'] + ' ' + xm.root.at_xpath('certinfo/userinfo/value/row')['iname'] + ' ' + xm.root.at_xpath('certinfo/userinfo/value/row')['oname']
    review= xm.root.at_xpath('certinfo/claims/row')['posclaimscount'] + '/' + xm.root.at_xpath('certinfo/claims/row')['negclaimscount']
    rdate= xm.root.at_xpath('certinfo/claims/row')['claimslastdate']
    Person.create(wmid: wmid,attestate_id: attestate_id, lvl: lvl, date:date, name: name, review:review, rdate:rdate)

    end
  def sort_column
    Person.column_names.include?(params[:sort])? params[:sort] : 'name'

  end
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : 'asc'

  end

end
