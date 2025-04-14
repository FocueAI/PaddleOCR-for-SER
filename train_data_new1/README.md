def _parse_label(self, label, encode_res):
    gt_label = []
    if label.lower() in ["other", "others", "ignore"]:
        gt_label.extend([0] * len(encode_res["input_ids"]))
    else:
        gt_label.append(self.label2id_map[("b-" + label).upper()])
        gt_label.extend(
            [self.label2id_map[("i-" + label).upper()]]
            * (len(encode_res["input_ids"]) - 1)
        )
    return gt_label


    由于该模型会自动忽略掉 other 标签，因此我们需要将其他标签转换为其他标签。
