module ActiveForce
  module Association
    class HasManyAssociation < Association

      private

      def default_foreign_key
        infer_foreign_key_from_model @parent
      end

      def define_relation_method
        association = self
        @parent.send :define_method, @relation_name do
          association_cache.fetch __method__ do
            query = association.relation_model.query
            query.options association.options
            association_cache[__method__] = query.where association.foreign_key => self.id
          end
        end
      end
    end
  end
end
