Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C95EF4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 00:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfGCW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 18:58:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:40598 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCW6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:58:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x63MvsFd012377;
        Wed, 3 Jul 2019 17:57:55 -0500
Message-ID: <01ca95431a642133293534502975765dba993ada.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 OPT1] driver core: Fix use-after-free and double free
 on glue directory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Muchun Song <smuchun@gmail.com>
Cc:     rafael@kernel.org, prsood@codeaurora.org, mojha@codeaurora.org,
        gkohli@codeaurora.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 08:57:53 +1000
In-Reply-To: <20190703193717.GB8452@kroah.com>
References: <20190626143823.7048-1-smuchun@gmail.com>
         <20190703193717.GB8452@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 21:37 +0200, Greg KH wrote:
> Ok, I guess I have to take this patch, as the other one is so bad :)
> 
> But, I need a very large comment here saying why we are poking around in
> a kref and why we need to do this, at the expense of anything else.
> 
> So can you respin this patch with a comment here to help explain it so
> we have a chance to understand it when we run across this line in 10
> years?

Also are we confident that an open dir on the glue dir from userspace
won't keep the kref up ?

Cheers,
Ben.


