Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817C8146C79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAWPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 10:18:19 -0500
Received: from foss.arm.com ([217.140.110.172]:40988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgAWPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:18:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078E41FB;
        Thu, 23 Jan 2020 07:18:19 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C70113F68E;
        Thu, 23 Jan 2020 07:18:17 -0800 (PST)
Date:   Thu, 23 Jan 2020 15:17:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200123151755.GA39963@bogus>
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <20200122121538.GA31240@bogus>
 <20200123103033.GA7511@bogus>
 <20200123112711.mggm7ayxcqnr54yf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123112711.mggm7ayxcqnr54yf@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 04:57:11PM +0530, Viresh Kumar wrote:

[...]
>
> Still it looks strange that the warning comes only after my patch :)
>

Yes indeed, I spent some time last evening and hopefully close, will
continue later today.

> Should I send V5 (fixed few comments after reviews) now ?

May be wait until tomorrow ? I will try to review as I try to debug the
warning.

--
Regards,
Sudeep
