Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C9173577
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 11:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgB1Kki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 05:40:38 -0500
Received: from foss.arm.com ([217.140.110.172]:36324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgB1Kki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:40:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65774B2;
        Fri, 28 Feb 2020 02:40:37 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E09FB3F73B;
        Fri, 28 Feb 2020 02:40:36 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:40:34 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     linuxarm@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpu-topology: Fix the potential data corruption
Message-ID: <20200228104034.GB26973@bogus>
References: <1582878945-50415-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582878945-50415-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 04:35:45PM +0800, Zeng Tao wrote:
> Currently there are only 10 bytes to store the cpu-topology info.
> That is:
> snprintf(buffer, 10, "cluster%d",i);
> snprintf(buffer, 10, "thread%d",i);
> snprintf(buffer, 10, "core%d",i);
>
> In the boundary test, if the cluster number exceeds 100, there will be a

I don't understand you mention of 100 in particular above. I can see issue
if there are cluster with more than 2-digit id. Though highly unlikely for
now, but I don't have objection to the patch.

--
Regards,
Sudeep
