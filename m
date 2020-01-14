Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F813A763
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 11:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgANKaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 05:30:01 -0500
Received: from foss.arm.com ([217.140.110.172]:50474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANKaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:30:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF305142F;
        Tue, 14 Jan 2020 02:29:59 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056CC3F6C4;
        Tue, 14 Jan 2020 02:29:58 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:29:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Message-ID: <20200114102956.GB10403@bogus>
References: <1578725620-39677-1-git-send-email-prime.zeng@hisilicon.com>
 <20200113101922.GE52694@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E41D1@DGGEMM506-MBX.china.huawei.com>
 <20200113122101.GA49933@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E59BA@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340E59BA@DGGEMM506-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:42:25AM +0000, Zengtao (B) wrote:
> Could you help to explain here?
> I understand there are two abnormal cases:
> 1. The cpu node exist in the device tree, but not a possible cpu.
> This case can be caught by of_cpu_node_to_id's return value.

Yes if of_cpu_node_to_id returns -ENODEV, it means there's no logical
CPU associated with this DT node.

> 2. The cpu node does not exist. This case can be caught by above logic. Or
> do you think of_parse_phandle's return value is enough?

Again yes, there's nothing extra needed.

The only change you need is to consider -ENODEV while handling the case(1)

--
Regards,
Sudeep

