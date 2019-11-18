Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CDD100EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 23:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKRWng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 17:43:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37812 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKRWnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:43:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so15257929lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfeVkemyC8oyPuWZJoeCqGa9v7ojQFXCd2NHyi2TdYw=;
        b=S8hsXmjpYuCsCskV7Y6l4Rpaulk2jrQL2fKqFec12o+n9Qvb/dPitq0+qUlugpSo6F
         ZkJobCv9kiUVHi3wMyjgoxCtZX4oHPziEGuXIrlf9l3SJFu7VLlsukig7PSKmqjpgu4o
         qt5e38JqN5+5VI57msYHUzvXFy5DgUiliewtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfeVkemyC8oyPuWZJoeCqGa9v7ojQFXCd2NHyi2TdYw=;
        b=odbH4TxergB1fCtV0fFLcudzqSNF1PYJgzZ3UPNmZJvWJum6Xn5PA/to3oBXFdTLHs
         pm0WvDufhXhcfOmVgsL9WF7iChJqPZlQVKE5ciGsvugdyJe2FCv+fmYNXOHLjGzzS9Js
         ArFSOUCADOlHJ3BcdpNBcr3BeO6QcTwGbrctfi+1a9LlT/VWr5yL0QVfhN5iZl+DmZ0p
         bZW+LDmhPXQRP2UU2YXHKgnEcTF2p/GjB8P7Iv6O74dzxvVX8kcQtQvXqUGs4dWvoklB
         gWpFsKxXjDue/TuqINWrKhV659zB30mFeKmlZBDH2Utu5akJhIgAYcF2qqkotUJz9CKJ
         9Xfw==
X-Gm-Message-State: APjAAAX+8uf2d1dtZk/0MaoLtuO2OUsfk4+v9zdzGohmZBFEIc+Kfyfd
        SN2cgj4hqcPYcYSCLLDg5y8MGzrzEiQ=
X-Google-Smtp-Source: APXvYqwKLz5YlaUm+Ro2/yyxUCnCRGciF1oGamnjQjFv2T6rtM9+zRyUcoifbcQ5JJyucfU7d2eFAw==
X-Received: by 2002:ac2:43c9:: with SMTP id u9mr1217304lfl.180.1574117010853;
        Mon, 18 Nov 2019 14:43:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u12sm9192910lje.1.2019.11.18.14.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 14:43:29 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l14so8561226lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:43:29 -0800 (PST)
X-Received: by 2002:ac2:46d7:: with SMTP id p23mr1241289lfo.104.1574117008414;
 Mon, 18 Nov 2019 14:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20191118154435.20357-1-sibis@codeaurora.org> <0101016e7f30ad15-18908ef0-a2b9-4a2a-bf32-6cb3aa447b01-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e7f30ad15-18908ef0-a2b9-4a2a-bf32-6cb3aa447b01-000000@us-west-2.amazonses.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 18 Nov 2019 14:42:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft5jGagsFS2yBeJCLt9R26RQjx9bfMxhQu8Jj4uc4ca40w@mail.gmail.com>
Message-ID: <CAE=gft5jGagsFS2yBeJCLt9R26RQjx9bfMxhQu8Jj4uc4ca40w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add OSM L3 interconnect
 provider support
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Mon, Nov 18, 2019 at 7:45 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On some Qualcomm SoCs, Operating State Manager (OSM) controls the
> resources of scaling L3 caches. Add a driver to handle bandwidth
> requests to OSM L3 from CPU/GPU.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |   7 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/osm-l3.c | 284 +++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/osm-l3.c
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index ecf057d7e2409..17aee5b0f15b7 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -5,6 +5,13 @@ config INTERCONNECT_QCOM
>         help
>           Support for Qualcomm's Network-on-Chip interconnect hardware.
>
> +config INTERCONNECT_QCOM_OSM_L3
> +       tristate "Qualcomm OSM L3 interconnect driver"
> +       depends on INTERCONNECT_QCOM || COMPILE_TEST

Should we depend on something sdm845 here?

> +       help
> +         Say y here to support the Operating State Manager (OSM) interconnect
> +         driver which controls the scaling of L3 caches on Qualcomm SoCs.
> +
>  config INTERCONNECT_QCOM_QCS404
>         tristate "Qualcomm QCS404 interconnect driver"
>         depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 9adf9e380545e..8d86d6515ffc9 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,10 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +icc-osm-l3-objs                                := osm-l3.o
>  qnoc-msm8974-objs                      := msm8974.o
>  qnoc-qcs404-objs                       := qcs404.o
>  qnoc-sdm845-objs                       := sdm845.o
>  icc-smd-rpm-objs                       := smd-rpm.o
>
> +obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> new file mode 100644
> index 0000000000000..5e9f9ce02863b
> --- /dev/null
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -0,0 +1,284 @@
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
> +       container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
> +
> +enum {
> +       SDM845_MASTER_OSM_L3_APPS = SLAVE_TCU + 1,
> +       SDM845_SLAVE_OSM_L3,
> +};

Should these just go in qcom,sdm845.h? Seems nice to have them all in
one place, and then they can be accessed in the DT if needed.

> +
> +struct qcom_osm_l3_icc_provider {
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
> +DEFINE_QNODE(osm_l3, SDM845_SLAVE_OSM_L3, 16);
> +
> +static struct qcom_icc_node *sdm845_osm_l3_nodes[] = {

const?

> +       [MASTER_OSM_L3_APPS] = &osm_apps_l3,
> +       [SLAVE_OSM_L3] = &osm_l3,
> +};
> +
> +static struct qcom_icc_desc sdm845_osm_l3 = {
> +       .nodes = sdm845_osm_l3_nodes,
> +       .num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
> +};
> +
> +static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +                             u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +       *agg_avg += avg_bw;
> +       *agg_peak = max_t(u32, *agg_peak, peak_bw);
> +
> +       return 0;
> +}

Georgi, I wonder if it's a good idea to make a small collection of
"std" aggregate functions in the interconnect core that a driver can
just point to if it's doing something super standard like this (ie
driver->aggregate = icc_std_aggregate;). This is probably fine as-is
for now, but if we see a lot more copy/pastes of this function we
should think about it.

> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +       struct qcom_osm_l3_icc_provider *qp;
> +       struct icc_provider *provider;
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
> +               qcom_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
> +                                  &agg_avg, &agg_peak);
> +
> +       rate = max(agg_avg, agg_peak);
> +       rate = icc_units_to_bps(rate);
> +       do_div(rate, qn->buswidth);
> +
> +       for (index = 0; index < qp->max_state; index++) {

If the rate is too high, you'll end up setting max_state into the
register. That's probably bad, right? (Or maybe it's not because the
table ends with the same value twice, but it seems like relying on an
implementation detail). We could guard against that by only iterating
to index < qp->max_state - 1.

> +               if (qp->lut_tables[index] >= rate)
> +                       break;
> +       }
> +
> +       writel_relaxed(index, qp->base + REG_PERF_STATE);
> +
> +       return 0;
> +}
> +
> +static int qcom_osm_l3_remove(struct platform_device *pdev)
> +{
> +       struct qcom_osm_l3_icc_provider *qp = platform_get_drvdata(pdev);
> +       struct icc_provider *provider = &qp->provider;
> +       struct icc_node *n;
> +
> +       list_for_each_entry(n, &provider->nodes, node_list) {

There was a comment on one of the other threads that we've been
copy/pasting this snippet around and it's wrong because it doesn't use
the _safe variant of the macro. So we end up destroying the list we're
iterating over.

Georgi, did you have a plan to refactor this, or should we just change
this to be the _safe version?

> +               icc_node_del(n);
> +               icc_node_destroy(n->id);
> +       }
> +
> +       return icc_provider_del(provider);
> +}
> +
> +static int qcom_osm_l3_probe(struct platform_device *pdev)
> +{
> +       u32 info, src, lval, i, prev_freq = 0, freq;
> +       static unsigned long hw_rate, xo_rate;
> +       struct qcom_osm_l3_icc_provider *qp;
> +       const struct qcom_icc_desc *desc;
> +       struct icc_onecell_data *data;
> +       struct icc_provider *provider;
> +       struct qcom_icc_node **qnodes;
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

It's a little weird there's a constant divide in there, though I guess
it's in the cpufreq driver as well. I guess this is fine if it's
likely to stay there (and the same) when this driver is generalized
for other SoCs.

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

"core counts" seems like a copied comment that doesn't apply.

But you only look at freq and not core count, is that really
equivalent to the table's boundary condition? Or do you need to be
comparing info == info_prev?

> +                * end of table
> +                */
> +               if (i > 0 && prev_freq == freq)
> +                       break;
> +
> +               qp->lut_tables[i] = freq;
> +               prev_freq = freq;
> +       }
> +       qp->max_state = i;

Should we error out or complain if there are too few entries, or if
the table is not in increasing order?

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

Not a super useful comment.


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
> +       qcom_osm_l3_remove(pdev);
> +       return ret;
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
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
