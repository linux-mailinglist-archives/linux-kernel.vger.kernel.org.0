Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6B12D3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 20:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfL3TBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 14:01:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:60468 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3TBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:01:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9AA9E536;
        Mon, 30 Dec 2019 19:01:06 +0000 (UTC)
Date:   Mon, 30 Dec 2019 12:01:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>, lizefan@huawei.com,
        Harry Wei <harryxiyou@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] docs/zh_CN: add Chinese version of embargoed
 hardware issues
Message-ID: <20191230120105.7776cbb4@lwn.net>
In-Reply-To: <1576811085-30544-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576811085-30544-1-git-send-email-alex.shi@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 11:04:43 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Embargoed hardware issues is a necessary process guide, but leak of
> Chinese version, since there is more Chinese hardware vendors in market.
> We'd better have a Chinese version of this guide.
> 
> This patch translate the guide, add it into toctree. and also add a link
> stub for the original doc.

I've applied this (and the other two as well), thanks.

jon
