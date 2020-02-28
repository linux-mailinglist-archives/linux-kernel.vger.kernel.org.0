Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B03173CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgB1QSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:18:31 -0500
Received: from foss.arm.com ([217.140.110.172]:40880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1QSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:18:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4BA31B;
        Fri, 28 Feb 2020 08:18:30 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B08E3F73B;
        Fri, 28 Feb 2020 08:18:28 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:18:20 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, robh@kernel.org,
        viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: add smc/hvc transport
Message-ID: <20200228161820.GA17229@bogus>
References: <1582701171-26842-1-git-send-email-peng.fan@nxp.com>
 <1582701171-26842-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582701171-26842-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:12:51PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Take arm,smc-id as the 1st arg, and protocol id as the 2nd arg when
> issuing SMC/HVC. Since we need protocol id, so add this parameter

And why do we need protocol id here ? I couldn't find it out myself.
I would like to know why/what/how is it used in the firmware(smc/hvc
handler). I hope you are not mixing the need for multiple channel with
protocol id ? One can find out id from the command itself, no need to
pass it and hence asking here for more details.

-- 
Regards,
Sudeep
