Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318CB6606F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 22:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfGKUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 16:11:28 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40052 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728194AbfGKUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:11:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F412F8EE2F6;
        Thu, 11 Jul 2019 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562875887;
        bh=eJpN0hT0dPASpoxiTeZeS1Zqd+8dvu3pAn+RAEai40M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wab+479UlzvH9iwSvlN/IS2yjRiE7OP9+DO69A/Ac8uIy9bkzkCgfkuM7n4iV/j9c
         98lE5jCz4EnZje3RzMAge2jVt6vngXbQuAvKk13eSJFyb1YGp2VqU9wiBQLBCrmfAI
         t2BK+nIY/Q94Q4s12onIvMX7cIboHyeFkPVZPh9c=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E4R7mDdzXBLo; Thu, 11 Jul 2019 13:11:26 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4140B8EE0C7;
        Thu, 11 Jul 2019 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562875886;
        bh=eJpN0hT0dPASpoxiTeZeS1Zqd+8dvu3pAn+RAEai40M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xctQD5llf5gK0Kt5CvU3qA2xkq/+WlSWMLSJ39J5pQ0RtP7Ow5sCXLIHSYb6meUxJ
         nyYX2lhHtH0Hg8KQyIPJVTuIldHUx99dhPLhGo5E+fyfmR2eLZAg3fCIYCoo5FxTCA
         Ma/ZxwsMepru1EEM5snfVgZy50R7ridZ66kQQ2/A=
Message-ID: <1562875878.2840.0.camel@HansenPartnership.com>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jul 2019 13:11:18 -0700
In-Reply-To: <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 10:29 +0100, Chris Wilson wrote:
> Quoting James Bottomley (2019-06-29 19:56:52)
> > The symptoms are really weird: the screen image is locked in
> > place.  The machine is still functional and if I log in over the
> > network can do anything I like, including killing the X server and
> > the display will never alter.  It also seems that the system is
> > accepting keyboard input because when it freezes I can cat
> > information to a file (if the mouse was over an xterm) and verify
> > over the network the file contents. Nothing unusual appears in
> > dmesg when the lockup happens.
> > 
> > The last kernel I booted successfully on the system was 5.0, so
> > I'll try compiling 5.1 to narrow down the changes.
> 
> It's likely this is panel self-refresh going haywire.
> 
> commit 8f6e87d6d561f10cfa48a687345512419839b6d8
> Author: José Roberto de Souza <jose.souza@intel.com>
> Date:   Thu Mar 7 16:00:50 2019 -0800
> 
>     drm/i915: Enable PSR2 by default
> 
>     The support for PSR2 was polished, IGT tests for PSR2 was added
> and
>     it was tested performing regular user workloads like browsing,
>     editing documents and compiling Linux, so it is time to enable it
> by
>     default and enjoy even more power-savings.
> 
> Temporary workaround would be to set i915.enable_psr=0

It looks plausible.  I have to say I was just about to mark a bisect
containing this as good, but that probably reflects my difficulty
reproducing the issue.

James

