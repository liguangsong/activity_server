# coding: utf-8
class User < ActiveRecord::Base

  validates_presence_of :name, :message => "不能为空"
  validates_length_of   :name, :in => 1..10, :message => "长度不正确"
  validates_presence_of :password, :message => "不能为空"
  validates_length_of   :password, :in => 1..10, :message => "长度不正确"
  validates_presence_of :question, :message => "不能为空"
  validates_length_of   :question, :in => 1..10, :message => "长度不正确"
  validates_presence_of :answer, :message => "不能为空"
  validates_length_of   :answer, :in => 1..10, :message => "长度不正确"

end
