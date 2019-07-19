Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99096EB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfGSTkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 15:40:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34326 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfGSTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:40:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so31834260ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WANkkcuR4ZoTS+A1wCt4CCKlkbrfCtHWWLwhmW2vQrw=;
        b=gtJxWlEI7uO9qW78f87XOfMG4qMIrai67FUQzFrdXCIUmzxIaZCyJrTacXlGm51h6k
         fNny7Uy6wJpZ7fs9KnSU3ahxt+WmphTauguJ7gpnrZaBtX0bj8AKRW+BhYCqTSJTKDV0
         +LFO3yAzLgGDz9j/bQbLAbIv2OicuyZUpCBvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WANkkcuR4ZoTS+A1wCt4CCKlkbrfCtHWWLwhmW2vQrw=;
        b=ML2GXaggsVfUKxIadtSHePrMZx2SiDesTEyH5rYawxKMZU3IKYf0Gn2R41EOJRt1AX
         TOEh7ty9e40lI7fkXFDHaC1G4YjmK3sOXSb9/m9k7bnGhiwBLz6Jsd6kOr288WoSCL2+
         aT7kBEXkaSfoWOQYTOktDtmn2P+Zs/nlV4wOY7vSIGTHqt/mIG9/8jUO8YHbbm3gneU+
         Es6/t7zCY5cx9jSgN/532WVZCzmv7dFjh+x/97WlcYgBkiQdEzDy7gBE+uILFajnKn3O
         hUQHc3h8Lc07VCLBDnKGGsT3x97CCFthaEXJ1zPXGSVJNPFFOfXEWg+Dspr/i+S8YvjQ
         pNKA==
X-Gm-Message-State: APjAAAWicneMlVSHorxlddyi0cHO2GtXc2Kh5BE8A8WIunE/tBXuB92Q
        ucLX5h5Rib8GmvhS/U+S4yNKZ1YoH8E=
X-Google-Smtp-Source: APXvYqyqSr1K2QUa2AKs0PKsvBm60jSL+9GB8PEWSAT8tnkFIbfiqoWlXqr1X9tW5mFtMxRi32imrg==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr28782266ljb.186.1563565230695;
        Fri, 19 Jul 2019 12:40:30 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id b192sm4644440lfg.75.2019.07.19.12.40.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 12:40:29 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id k18so31805184ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:40:29 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr28838104ljk.72.1563565228772;
 Fri, 19 Jul 2019 12:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190719154207.GA9708@phenom.ffwll.local>
In-Reply-To: <20190719154207.GA9708@phenom.ffwll.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Jul 2019 12:40:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEE4KGcyL0AJ6YxYvjPHUm9bn_7pZBCmqb-i3+j8p49Q@mail.gmail.com>
Message-ID: <CAHk-=wjEE4KGcyL0AJ6YxYvjPHUm9bn_7pZBCmqb-i3+j8p49Q@mail.gmail.com>
Subject: Re: [PULL] drm-next fixes for -rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 8:43 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> drm fixes for -rc1:
>
> nouveau:
> - bugfixes + TU116 enabling (minor iteration):w

Asking the important question:

 - WTH is that ":w" thing?

I have a theory that it's just a "I'm confused by 'vi'" marker.  Very
understandable.

But I'm also entertaining the possibility that it's a new "whistling
guy" emoticon. Or maybe a "hungry baby bird face" emoticon.

Admittedly not a _great_ new addition to the emoticons I've seen, but
hey, I'm not judging. Much.

I left it in the merge message for posterity, regardless.

            Linus
