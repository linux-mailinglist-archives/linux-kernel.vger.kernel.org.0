Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E86164BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBSRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:33:14 -0500
Received: from ms.lwn.net ([45.79.88.28]:35476 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgBSRdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:33:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3B0C42E5;
        Wed, 19 Feb 2020 17:33:10 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:33:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] docs: add a script to check sysctl docs
Message-ID: <20200219103305.733b7db9@lwn.net>
In-Reply-To: <20200219162527.61f99f45@heffalump.sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
        <20200218125923.685-8-steve@sk2.org>
        <20200219034416.4d82dc16@lwn.net>
        <20200219162527.61f99f45@heffalump.sk2.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 16:25:27 +0100
Stephen Kitt <steve@sk2.org> wrote:

> > > +# SPDX-License-Identifier: GPL-2.0-only    
> > 
> > By Documentation/process/license-rules.rst, that should be "GPL-2.0"; the
> > absence of a "+" means "only".  
> 
> Ah, thanks, I hadn’t noticed that. I’m used to the SPDX identifiers listed on
> the LF website, https://spdx.org/licenses/GPL-2.0-only.html in this case.
> (I’m not alone apparently, see “git grep GPL-2.0-only”...)

The SPDX tags got changed at some point, but the kernel community
declined to follow along.  We're being difficult as usual...:)

Thanks,

jon
