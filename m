Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0536ADC01
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfIIPVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 11:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfIIPVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:21:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5285D169E;
        Mon,  9 Sep 2019 08:21:17 -0700 (PDT)
Received: from usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CEAC63F59C;
        Mon,  9 Sep 2019 08:21:15 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -next] reset: reset-scmi: add missing handle initialisation
Date:   Mon,  9 Sep 2019 16:21:07 +0100
Message-Id: <20190909152107.4968-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scmi_reset_data->handle needs to be initialised at probe, so that it
can be used to access scmi reset protocol apis using the same later.

Since it was tested with a module that obtained handle elsewhere,
it was missed easily. Add the missing scmi_reset_data->handle
initialisation to fix the issue.

Fixes: c8ae9c2da1cc ("reset: Add support for resets provided by SCMI")
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reported-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/reset/reset-scmi.c | 1 +
 1 file changed, 1 insertion(+)

Hi Philipp,

I can either take this via ARM SoC as the driver is getting merged through
ARM SoC tree, or you can apply this once it gets landed in mainline.
I am fine with whatever you prefer.

Regards,
Sudeep


diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index c6d3c8427f14..b46df80ec6c3 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -102,6 +102,7 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.of_node = np;
 	data->rcdev.nr_resets = handle->reset_ops->num_domains_get(handle);
+	data->handle = handle;

 	return devm_reset_controller_register(dev, &data->rcdev);
 }
--
2.17.1

