Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E35136BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 12:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgAJLQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 06:16:32 -0500
Received: from foss.arm.com ([217.140.110.172]:42580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgAJLQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:16:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF8D328;
        Fri, 10 Jan 2020 03:16:28 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5BD53F703;
        Fri, 10 Jan 2020 03:16:27 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:16:22 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Message-ID: <20200110111622.GA39451@bogus>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
 <20200107144940.GA47473@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B8545@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340B8545@dggemm526-mbx.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 01:57:34AM +0000, Zengtao (B) wrote:
[...]

> I have the same concern, I have tried to find out some other return values
> But seems not good enough.
> Maybe it's better to introduce a new function to replace of_cpu_node_to_id
> Any good suggestion?
>

No I don't have any. So please drop the extra logic, add a comment on
-ENODEV return value and use it as needed.

--
Regards,
Sudeep
