Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5497885515
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfHGVVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 17:21:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45450 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbfHGVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:21:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so16839233otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E83XgpEkU31YbQflVm+2d8Dk6GH8VjLyD8fq87CgSg0=;
        b=HoDCeTLypp5Si0vgn1wwRgjP58elTOAyCM8ECe+98c54QE05zUUVL0+15GIEM0uDvc
         ZcYtpAnGam/tB0Z4W+f1ALh2s3l/Bkerik2K4/wsWOXSnuJQY1D+HBF9NsS1DPGVwGDn
         2mnGTY1vzWlJmum6enzSLifDcDTExfKFiTxtV7nDXDDM1gHf+att1j3G83MtJcXWl3db
         LLd8DWnFmfTfk6bR6GijLuRXQnyczXwmB1jDb9s2jhGvyJEw//pJlIuQdzK+4wfNMVEl
         Mg/Ct3hPWgbZFyXbMAt19/rfDVuMDViZK+hzQ3fj8E0G5pjSTr+rl5knSsz5uJ7WHj50
         yP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E83XgpEkU31YbQflVm+2d8Dk6GH8VjLyD8fq87CgSg0=;
        b=mNZRC42XqOHkZXYlggk2Nm8Lh6I8NpxkVbySxPTm4JXJTdPmq5Ge++371+lG8BxZAN
         GDKRbpt9zJ1/nkhDdcZQ72JItflcI7gH/BcIxijy4c6kAi7mQVWtkpPHVxpEOuGpkDcH
         Y8CpsLa8rzkDItSZLTOGeEWNvFsOqJD/CRRJTvV6H0Q0s4MyxxZl2pgbHStenbkMHSnC
         04uG2Otg+RxWdgq2/DZWp2urotkQFrzqgdbil55BodkG3k1lqN9yA+S7qK6gqmKp+7Cc
         58xpayFL6cbMg0IlpUWp9GpZOMom+nRWQS6gBe+R3A9XDdIMr4b7mWteYBx1ZuTW2EzK
         zZjw==
X-Gm-Message-State: APjAAAUXLcfOItawtb07ZXzZKV7wE6KCcgeOLHuD+m4VXMEh+C/v8OWj
        asNE0xDYlloNn4U8CQjpI7zc6E6kM0L/XGCCgjJxAg==
X-Google-Smtp-Source: APXvYqy+h3tx5EMDyOTvI1YjhXXlsCtiUzMj3+xSOqX5Bwn5yidKZmCk+lQqEb1d3JivNizN/AeWBpG3u1YEfNfACMc=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr10153558otj.195.1565212900357;
 Wed, 07 Aug 2019 14:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190807112432.26521-1-sibis@codeaurora.org> <20190807112432.26521-3-sibis@codeaurora.org>
In-Reply-To: <20190807112432.26521-3-sibis@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 7 Aug 2019 14:21:04 -0700
Message-ID: <CAGETcx8JgigJpRgjXsG+xChLUPrASRO7BapkYaSrvvTdQKfEuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add OSM L3 interconnect provider support
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        agross@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 4:24 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On some Qualcomm SoCs, Operating State Manager (OSM) controls the
> resources of scaling L3 caches. Add a driver to handle bandwidth
> requests to OSM L3 from CPU/GPU.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |   7 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/osm-l3.c | 292 +++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/osm-l3.c
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index d5e70ebc24108..f6c2a11a1a2c9 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -5,6 +5,13 @@ config INTERCONNECT_QCOM
>         help
>           Support for Qualcomm's Network-on-Chip interconnect hardware.
>
> +config INTERCONNECT_QCOM_OSM_L3
> +       tristate "Qualcomm OSM L3 interconnect driver"
> +       depends on INTERCONNECT_QCOM || COMPILE_TEST
> +       help
> +         Say y here to support the Operating State Manager (OSM) interconnect
> +         driver which controls the scaling of L3 caches on Qualcomm SoCs.
> +
>  config INTERCONNECT_QCOM_SDM845
>         tristate "Qualcomm SDM845 interconnect driver"
>         depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 1c1cea690f922..9078af5fed109 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +icc-osm-l3-objs                                := osm-l3.o
>  qnoc-sdm845-objs                       := sdm845.o
>
> +obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> new file mode 100644
> index 0000000000000..1e7dfce6f4f9b
> --- /dev/null
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
> +#include <dt-bindings/interconnect/qcom,sdm845.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#define LUT_MAX_ENTRIES                        40U
> +#define LUT_SRC                                GENMASK(31, 30)
> +#define LUT_L_VAL                      GENMASK(7, 0)
> +#define LUT_ROW_SIZE                   32
> +#define CLK_HW_DIV                     2
> +
> +/* Register offsets */
> +#define REG_ENABLE                     0x0
> +#define REG_FREQ_LUT                   0x110
> +#define REG_PERF_STATE                 0x920
> +
> +#define OSM_L3_MAX_LINKS               1
> +
> +#define to_qcom_provider(_provider) \
> +       container_of(_provider, struct qcom_icc_provider, provider)
> +
> +enum {
> +       SDM845_MASTER_OSM_L3_APPS = SLAVE_TCU + 1,
> +       SDM845_MASTER_OSM_L3_GPU,
> +       SDM845_SLAVE_OSM_L3,
> +};
> +
> +struct qcom_icc_provider {
> +       void __iomem *base;
> +       unsigned int max_state;
> +       unsigned long lut_tables[LUT_MAX_ENTRIES];
> +       struct icc_provider provider;
> +};
> +
> +/**
> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @links: an array of nodes where we can go next while traversing
> + * @id: a unique node identifier
> + * @num_links: the total number of @links
> + * @buswidth: width of the interconnect between a node and the bus
> + */
> +struct qcom_icc_node {
> +       const char *name;
> +       u16 links[OSM_L3_MAX_LINKS];
> +       u16 id;
> +       u16 num_links;
> +       u16 buswidth;
> +};
> +
> +struct qcom_icc_desc {
> +       struct qcom_icc_node **nodes;
> +       size_t num_nodes;
> +};
> +
> +#define DEFINE_QNODE(_name, _id, _buswidth, ...)                       \
> +               static struct qcom_icc_node _name = {                   \
> +               .name = #_name,                                         \
> +               .id = _id,                                              \
> +               .buswidth = _buswidth,                                  \
> +               .num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),      \
> +               .links = { __VA_ARGS__ },                               \
> +       }
> +
> +DEFINE_QNODE(osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
> +DEFINE_QNODE(osm_gpu_l3, SDM845_MASTER_OSM_L3_GPU, 16, SDM845_SLAVE_OSM_L3);
> +DEFINE_QNODE(osm_l3, SDM845_SLAVE_OSM_L3, 16);
> +
> +static struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
> +       [MASTER_OSM_L3_APPS] = &osm_apps_l3,
> +       [MASTER_OSM_L3_GPU] = &osm_gpu_l3,
> +       [SLAVE_OSM_L3] = &osm_l3,
> +};
> +
> +static struct qcom_icc_desc sdm845_osm_l3 = {
> +       .nodes = sdm845_osm_l3_nodes,
> +       .num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
> +};
> +
> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +                             u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +       *agg_avg += avg_bw;
> +       *agg_peak = max_t(u32, *agg_peak, peak_bw);
> +
> +       return 0;
> +}
> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +       struct icc_provider *provider;
> +       struct qcom_icc_provider *qp;
> +       struct qcom_icc_node *qn;
> +       struct icc_node *n;
> +       unsigned int index;
> +       u32 agg_peak = 0;
> +       u32 agg_avg = 0;
> +       u64 rate;
> +
> +       qn = src->data;
> +       provider = src->provider;
> +       qp = to_qcom_provider(provider);
> +
> +       list_for_each_entry(n, &provider->nodes, node_list)
> +               qcom_icc_aggregate(n, n->avg_bw, n->peak_bw,
> +                                  &agg_avg, &agg_peak);
> +
> +       rate = max(agg_avg, agg_peak);
> +       rate = icc_units_to_bps(rate);
> +       do_div(rate, qn->buswidth);
> +
> +       for (index = 0; index < qp->max_state; index++) {
> +               if (qp->lut_tables[index] >= rate)
> +                       break;
> +       }
> +
> +       writel_relaxed(index, qp->base + REG_PERF_STATE);
> +
> +       return 0;
> +}
> +
> +static int qcom_osm_l3_probe(struct platform_device *pdev)
> +{
> +       u32 info, src, lval, i, prev_freq = 0, freq;
> +       static unsigned long hw_rate, xo_rate;
> +       const struct qcom_icc_desc *desc;
> +       struct icc_onecell_data *data;
> +       struct icc_provider *provider;
> +       struct qcom_icc_node **qnodes;
> +       struct qcom_icc_provider *qp;
> +       struct icc_node *node;
> +       size_t num_nodes;
> +       struct clk *clk;
> +       int ret;
> +
> +       clk = clk_get(&pdev->dev, "xo");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       xo_rate = clk_get_rate(clk);
> +       clk_put(clk);
> +
> +       clk = clk_get(&pdev->dev, "alternate");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
> +       clk_put(clk);
> +
> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +       if (!qp)
> +               return -ENOMEM;
> +
> +       qp->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(qp->base))
> +               return PTR_ERR(qp->base);
> +
> +       /* HW should be in enabled state to proceed */
> +       if (!(readl_relaxed(qp->base + REG_ENABLE) & 0x1)) {
> +               dev_err(&pdev->dev, "error hardware not enabled\n");
> +               return -ENODEV;
> +       }
> +
> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +               info = readl_relaxed(qp->base + REG_FREQ_LUT +
> +                                    i * LUT_ROW_SIZE);
> +               src = FIELD_GET(LUT_SRC, info);
> +               lval = FIELD_GET(LUT_L_VAL, info);
> +               if (src)
> +                       freq = xo_rate * lval;
> +               else
> +                       freq = hw_rate;
> +
> +               /*
> +                * Two of the same frequencies with the same core counts means
> +                * end of table
> +                */
> +               if (i > 0 && prev_freq == freq)
> +                       break;
> +
> +               qp->lut_tables[i] = freq;
> +               prev_freq = freq;
> +       }
> +       qp->max_state = i;
> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       qnodes = desc->nodes;
> +       num_nodes = desc->num_nodes;
> +
> +       data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       provider = &qp->provider;
> +       provider->dev = &pdev->dev;
> +       provider->set = qcom_icc_set;
> +       provider->aggregate = qcom_icc_aggregate;
> +       provider->xlate = of_icc_xlate_onecell;
> +       INIT_LIST_HEAD(&provider->nodes);
> +       provider->data = data;
> +
> +       ret = icc_provider_add(provider);
> +       if (ret) {
> +               dev_err(&pdev->dev, "error adding interconnect provider\n");
> +               return ret;
> +       }
> +
> +       for (i = 0; i < num_nodes; i++) {
> +               size_t j;
> +
> +               node = icc_node_create(qnodes[i]->id);
> +               if (IS_ERR(node)) {
> +                       ret = PTR_ERR(node);
> +                       goto err;
> +               }
> +
> +               node->name = qnodes[i]->name;
> +               node->data = qnodes[i];
> +               icc_node_add(node, provider);
> +
> +               dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
> +                       qnodes[i]->name, node->id);
> +
> +               /* populate links */
> +               for (j = 0; j < qnodes[i]->num_links; j++)
> +                       icc_link_create(node, qnodes[i]->links[j]);
> +
> +               data->nodes[i] = node;
> +       }
> +       data->num_nodes = num_nodes;
> +
> +       platform_set_drvdata(pdev, qp);
> +
> +       return ret;
> +err:
> +       list_for_each_entry(node, &provider->nodes, node_list) {
> +               icc_node_del(node);
> +               icc_node_destroy(node->id);
> +       }
> +
> +       icc_provider_del(provider);
> +       return ret;
> +}
> +
> +static int qcom_osm_l3_remove(struct platform_device *pdev)
> +{
> +       struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +       struct icc_provider *provider = &qp->provider;
> +       struct icc_node *n;
> +
> +       list_for_each_entry(n, &provider->nodes, node_list) {
> +               icc_node_del(n);
> +               icc_node_destroy(n->id);
> +       }
> +
> +       return icc_provider_del(provider);
> +}
> +
> +static const struct of_device_id osm_l3_of_match[] = {
> +       { .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_osm_l3 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, osm_l3_of_match);
> +
> +static struct platform_driver osm_l3_driver = {
> +       .probe = qcom_osm_l3_probe,
> +       .remove = qcom_osm_l3_remove,
> +       .driver = {
> +               .name = "osm-l3",
> +               .of_match_table = osm_l3_of_match,
> +       },
> +};
> +module_platform_driver(osm_l3_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm OSM L3 interconnect driver");
> +MODULE_LICENSE("GPL v2");

Did a quick scan of the code and it's not clear how you connect the L3
interconnect provider to the rest of the interconnect. I don't see any
DT or code references to the rest of the interconnects in the system.
If GPU is making a bandwidth request all the way to L3, how do you
make sure the interconnects between GPU and L3 also scale up properly.

-Saravana
