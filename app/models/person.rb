class Person < ActiveRecord::Base
  belongs_to :attestate

  def self.search(par)
    if par[:search]
      if par[:lvl1] == ''
        par[:lvl1] = 0
      end
      if par[:lvl2] == ''
        par[:lvl2] = 10000
      end

      #par[:lvl2] ||= '0'
      x=where('name LIKE ?', "%#{par[:search]}%")
      x=x.where('wmid LIKE ?', "%#{par[:wmid]}%")
      x=x.where('lvl >= ?', par[:lvl1])
      x=x.where('lvl <= ?', par[:lvl2])
      if par[:att]!='0'
        x=x.where('attestate_id = ?', par[:att])
      end

      return x
    else
      default_scoped
    end
  end
end
