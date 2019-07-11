Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62A6648C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGJPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 11:01:16 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40632 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfGJPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:01:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E3A198EE24C;
        Wed, 10 Jul 2019 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562770875;
        bh=kTKmUcjPIZy+cb272mn02BGDr/iISuwOGoTGGPFVmB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UTIwU8xij1Z+s9YfJbAnDiV3mL1XHgtV2hGw+QEjW+zIbFTQqNbzuoGBlSLHfLhlA
         pPgwIA07Mh/i6aP5OiucFcP4yQAuuOFr7rvO6MiH1fcP8t719juppreWl7YzPruswN
         igUaGuGI2HcT5oLofkY6FD0TyRUzpWqcCPOWOhNo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w7OgwRly1-Ej; Wed, 10 Jul 2019 08:01:15 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6C5948EE147;
        Wed, 10 Jul 2019 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562770875;
        bh=kTKmUcjPIZy+cb272mn02BGDr/iISuwOGoTGGPFVmB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UTIwU8xij1Z+s9YfJbAnDiV3mL1XHgtV2hGw+QEjW+zIbFTQqNbzuoGBlSLHfLhlA
         pPgwIA07Mh/i6aP5OiucFcP4yQAuuOFr7rvO6MiH1fcP8t719juppreWl7YzPruswN
         igUaGuGI2HcT5oLofkY6FD0TyRUzpWqcCPOWOhNo=
Message-ID: <1562770874.3213.14.camel@HansenPartnership.com>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 08:01:14 -0700
In-Reply-To: <1561834612.3071.6.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-29 at 11:56 -0700, James Bottomley wrote:
> The symptoms are really weird: the screen image is locked in place. 
> The machine is still functional and if I log in over the network I
> can do anything I like, including killing the X server and the
> display will never alter.  It also seems that the system is accepting
> keyboard input because when it freezes I can cat information to a
> file (if the mouse was over an xterm) and verify over the network the
> file contents. Nothing unusual appears in dmesg when the lockup
> happens.
> 
> The last kernel I booted successfully on the system was 5.0, so I'll
> try compiling 5.1 to narrow down the changes.

I've confirmed that 5.1 doesn't have the regression and I'm now trying
to bisect the 5.2 merge window, but since the problem takes quite a
while to manifest this will take some time.  Any hints about specific
patches that might be the problem would be welcome.

James

