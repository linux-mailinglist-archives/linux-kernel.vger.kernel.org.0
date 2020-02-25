Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD57016BEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgBYKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:39:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:53262 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgBYKjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:39:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 37F2B738;
        Tue, 25 Feb 2020 10:39:38 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:39:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kref: Clarify the use of two kref_put() in
 example code
Message-ID: <20200225033933.190a259d@lwn.net>
In-Reply-To: <20200219111055.GA4552@mani>
References: <20200213125311.21256-1-manivannan.sadhasivam@linaro.org>
        <20200219035818.08ad246f@lwn.net>
        <20200219111055.GA4552@mani>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 16:40:55 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> Jakub mistakenly spotted one refcounting issue in one of my patchset:
> https://lkml.org/lkml/2020/2/3/926
> 
> Then I tried to show him the kernel doc for kref and that's where I got this
> example code slightly confusing. And while looking into the log, I noticed that
> someone deleted the kref_put in error path mistakenly and that commit got
> reverted after that. This issue was even discussed in stack overflow.
> 
> http://stackoverflow.com/questions/20093127/why-kref-doc-of-linux-kernel-omits-kref-put-when-kthread-run-fail
> 
> So I thought about making it more clear of why the kref_put is needed in error
> path.

OK, I've applied it, thanks.

jon
