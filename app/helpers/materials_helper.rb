
module MaterialsHelper
  DEFAULT_ATTRIBUTES = ["id", "function", "group", "link", "ipc_standard"]
  MATERIAL_ATTRIBUTES = {
    "conductive" => ["foil_roughness", "flexible", "thermal_conductivity"],
    "dielectric" => ["flexible", "ul_94", "cti", "df", "dielectric_breakdown",
      "dk", "mot", "t260", "t280", "t300", "td_min",
      "tg_min", "thermal_conductivity", "water_absorption", "z_cte",
      "z_cte_after_tg", "z_cte_before_tg", "ipc_slash_sheet"],
    "soldermask" => ["flexible", "thermal_conductivity", "ipc_sm_840_class", "df", "dk", "electric_strength", "ul_94", "cti", "finish"],
    "stiffener" => [],
    "final_finish" => []
  }

  def attributes_by_material_function(material)
    material.attributes.slice(
      *DEFAULT_ATTRIBUTES+MATERIAL_ATTRIBUTES.fetch(material.function))
  end

  def styled_value(value, values)
    values_equal = values.uniq.size <= 1
    style="color: " + (values_equal ? "green" : "red")
    content_tag(:span, value, {style: style})
  end

  def show_attribute(attr)
    data = attr.humanize
    if Material::UNITS[attr.to_sym]
      data += "(#{Material::UNITS[attr.to_sym]})"
    end
    content_tag(:span, data)
  end
end
