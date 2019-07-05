Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3955F2D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfGDGaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 02:30:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:51566 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDGaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:30:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x646TtlE025587;
        Thu, 4 Jul 2019 01:29:56 -0500
Message-ID: <01fea5b8eda7f5ed985bf06905ca95bbe6414539.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 OPT1] driver core: Fix use-after-free and double free
 on glue directory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Muchun Song <smuchun@gmail.com>, rafael@kernel.org,
        prsood@codeaurora.org, mojha@codeaurora.org, gkohli@codeaurora.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 16:29:55 +1000
In-Reply-To: <20190704054126.GD347@kroah.com>
References: <20190626143823.7048-1-smuchun@gmail.com>
         <20190703193717.GB8452@kroah.com>
         <01ca95431a642133293534502975765dba993ada.camel@kernel.crashing.org>
         <20190704054126.GD347@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 07:41 +0200, Greg KH wrote:
> On Thu, Jul 04, 2019 at 08:57:53AM +1000, Benjamin Herrenschmidt
> wrote:
> > On Wed, 2019-07-03 at 21:37 +0200, Greg KH wrote:
> > > Ok, I guess I have to take this patch, as the other one is so bad
> > > :)
> > > 
> > > But, I need a very large comment here saying why we are poking
> > > around in
> > > a kref and why we need to do this, at the expense of anything
> > > else.
> > > 
> > > So can you respin this patch with a comment here to help explain
> > > it so
> > > we have a chance to understand it when we run across this line in
> > > 10
> > > years?
> > 
> > Also are we confident that an open dir on the glue dir from
> > userspace
> > won't keep the kref up ?
> 
> How do you "open" a directory which raises the kref?

Hrm.. kernfs foo .. not sure. You probably can't :-) I don't know.

Cheers,
Ben.

