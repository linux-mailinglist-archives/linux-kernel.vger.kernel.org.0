Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81C018C904
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 09:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCTIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 04:38:09 -0400
Received: from foss.arm.com ([217.140.110.172]:45856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgCTIiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:38:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D9B730E;
        Fri, 20 Mar 2020 01:38:08 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE2B3F305;
        Fri, 20 Mar 2020 01:42:09 -0700 (PDT)
Date:   Fri, 20 Mar 2020 08:37:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports support
Message-ID: <20200320083756.GA12067@e107533-lin.cambridge.arm.com>
References: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB4481F673F90C735F272C171F88F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481F673F90C735F272C171F88F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 08:27:47AM +0000, Peng Fan wrote:
> Hi Sudeep,
>
> > Subject: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports support
>
> Are you fine with this patchset? Or You expect multi channel support?
>
> We have some features depending on this for long time, so hope smc transports
> could be finalized sooner.
>

I have applied these patches as is, yet to push it out. I am waiting for
my v5.7 scmi PR to reach arm-soc next before I update my scmi branch. I will
let you know replying to this thread once that happens.

--
Regards,
Sudeep
