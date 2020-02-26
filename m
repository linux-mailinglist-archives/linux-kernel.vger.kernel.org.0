Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18E16FD65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 12:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBZLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 06:21:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:34376 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgBZLVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:21:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 803B26D9;
        Wed, 26 Feb 2020 11:21:42 +0000 (UTC)
Date:   Wed, 26 Feb 2020 04:21:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: fix filesystems/porting.rst whitespace
Message-ID: <20200226042137.05e9ead3@lwn.net>
In-Reply-To: <20200225165954.GA11763@cisco>
References: <20200220214009.11645-1-tycho@tycho.ws>
        <20200225032028.2bda9de8@lwn.net>
        <20200225165954.GA11763@cisco>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 09:59:54 -0700
Tycho Andersen <tycho@tycho.ws> wrote:

> > So I don't see that problem in my builds, and it doesn't show in the
> > version on kernel.org either.  What version of sphinx are you running?  
> 
> It's actually the default vim syntax highlighter that gets confused in
> my case,

So this is actually a vim bug, then, right?

Thanks,

jon
