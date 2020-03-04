Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69618178E85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 11:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgCDKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 05:40:14 -0500
Received: from foss.arm.com ([217.140.110.172]:60634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgCDKkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:40:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDD530E;
        Wed,  4 Mar 2020 02:40:13 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7FC03F534;
        Wed,  4 Mar 2020 02:40:12 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:40:05 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, viresh.kumar@linaro.org, f.fainelli@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Message-ID: <20200304103954.GA25004@bogus>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:06:59AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Take arm,smc-id as the 1st arg, leave the other args as zero for now.
> There is no Rx, only Tx because of smc/hvc not support Rx.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

[...]

> +static int smc_send_message(struct scmi_chan_info *cinfo,
> +			    struct scmi_xfer *xfer)
> +{
> +	struct scmi_smc *scmi_info = cinfo->transport_info;
> +	struct arm_smccc_res res;
> +
> +	shmem_tx_prepare(scmi_info->shmem, xfer);

How do we protect another thread/process on another CPU going and
modifying the same shmem with another request ? We may need notion
of channel with associated shmem and it is protected with some lock.

--
Regards,
Sudeep
