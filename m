Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8416BE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgBYKUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:20:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:53116 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgBYKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:20:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4E1416D9;
        Tue, 25 Feb 2020 10:20:34 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:20:28 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: fix filesystems/porting.rst whitespace
Message-ID: <20200225032028.2bda9de8@lwn.net>
In-Reply-To: <20200220214009.11645-1-tycho@tycho.ws>
References: <20200220214009.11645-1-tycho@tycho.ws>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 14:40:09 -0700
Tycho Andersen <tycho@tycho.ws> wrote:

> If we start with spaces instead of tabs, rst seems to get confused and
> italicize some things (presumably because of the `*'s).
> 
> Instead, let's switch to using leading tabs as we do elsewhere in the file.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> ---
>  Documentation/filesystems/porting.rst | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

So I don't see that problem in my builds, and it doesn't show in the
version on kernel.org either.  What version of sphinx are you running?

Thanks,

jon
