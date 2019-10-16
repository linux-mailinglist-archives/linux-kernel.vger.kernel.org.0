Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DAD8F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404891AbfJPLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:12:56 -0400
Received: from foss.arm.com ([217.140.110.172]:36758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404880AbfJPLMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:12:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432C328;
        Wed, 16 Oct 2019 04:12:55 -0700 (PDT)
Received: from stinger.cambridge.arm.com (stinger.cambridge.arm.com [10.1.137.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60A183F6C4;
        Wed, 16 Oct 2019 04:12:54 -0700 (PDT)
Message-ID: <23034ba3a6abfdf89d9ac6a7d623d9e05b929a5a.camel@arm.com>
Subject: Re: [PATCHv2 1/2] bus: arm-ccn: Enable stats for CCN-512
 interconnect
From:   Pawel Moll <pawel.moll@arm.com>
To:     Marek Bykowski <marek.bykowski@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, will@kernel.org
Date:   Wed, 16 Oct 2019 12:12:52 +0100
In-Reply-To: <20191016110612.17381ad6@gmail.com>
References: <1570454475-2848-1-git-send-email-marek.bykowski@gmail.com>
         <20191016110612.17381ad6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 10:06 +0100, Marek Bykowski wrote:
> Add compatible string for the ARM CCN-502 interconnect
> 
> Signed-off-by: Marek Bykowski <marek.bykowski@gmail.com>
> Signed-off-by: Boleslaw Malecki <boleslaw.malecki@tieto.com>
> ---
> Changelog v1->v2:
> - Change the subject to reflect where the driver got moved to (drivers/perf) from
>   (drivers/bus).
> - Add credit to my work mate that helped me validate the counts from
>   the interconnect.
> ---
>  drivers/perf/arm-ccn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 7dd850e02f19..b6e00f35a448 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -1545,6 +1545,7 @@ static int arm_ccn_remove(struct platform_device *pdev)
>  static const struct of_device_id arm_ccn_match[] = {
>         { .compatible = "arm,ccn-502", },
>         { .compatible = "arm,ccn-504", },
> +       { .compatible = "arm,ccn-512", },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, arm_ccn_match);

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel

