Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437215AFE9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF3NkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 09:40:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:46034 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfF3NkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:40:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E50282CF;
        Sun, 30 Jun 2019 13:40:07 +0000 (UTC)
Date:   Sun, 30 Jun 2019 07:40:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sheriff Esseson <sheriffesseson@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-kernel-mentees] [PATCH] Doc : doc-guide : Fix a typo
Message-ID: <20190630074006.477305c2@lwn.net>
In-Reply-To: <20190630071707.GA12881@localhost>
References: <20190628060111.24851-1-sheriffesseson@gmail.com>
        <20190630071707.GA12881@localhost>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jun 2019 08:17:07 +0100
Sheriff Esseson <sheriffesseson@gmail.com> wrote:

> > fix the disjunction by replacing "of" with "or".
> > 
> > Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
> > ---
> > -- 
> > 2.22.0
> >   
> 
> Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
> ---
> 
> changes in v2:
> - cc-ed Corbet.
> 
>  Documentation/doc-guide/kernel-doc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

So why are you sending me this again?  I applied it a few days ago and
told you so at the time.

jon
