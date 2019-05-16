Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A665209D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfEPOdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:33:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39232 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEPOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:33:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id m1so2451021vsr.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Slihxl2vu/lw+Vj+9GO27pAncTe7JgO+/vPnKvGqTt8=;
        b=P+WAajyHxtrheJmQBtpCzmFJDAq4xJj57p+ROllFvDuQCwWUfXdV7355eKHFj8Dalc
         XrQYQst69cQGWcX7TFmGNErrjo34vgWauycVsE2Oj8/eQ2gZefJpOMaGX8IOOsE2MLcs
         znt/CGUnSuDtPe/+BbT8ekK4zoSgENM1e0mbi/s0Kt6EtPoDNxNeLI0c78cy+oVpm6lP
         wntWw1WDGVRB+7Sc/nqShe/gvzEPcsmOX4cQDA0x6l7xDxh9nhaoYNWXLFsAKUZcKFIS
         K87uKuKlFj+LcH0bIgR05nnprGvuqIWc4rHVp4GJ3oLHM0lppFkzbngzhRmudC/zVVVR
         PiUQ==
X-Gm-Message-State: APjAAAUVJb+BCgso084iNT9Yd7gqTIgTs0wln1fFr7TewDV2YLUY672P
        TKrkSxhADKZTONpSyO2gh7x0tUtgYcfr7iLY/HOjPXboxls=
X-Google-Smtp-Source: APXvYqxgqHqxcis3VM15isZ2If1AqbFf6DmtSnzpBQfJ72a0QbaXliUxxUP1ClUcF+wulx/rfEPw3PiWRRatfC9Ox+g=
X-Received: by 2002:a67:f309:: with SMTP id p9mr22751634vsf.216.1558017231720;
 Thu, 16 May 2019 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190426145946.26537-1-ghalat@redhat.com>
In-Reply-To: <20190426145946.26537-1-ghalat@redhat.com>
From:   Grzegorz Halat <ghalat@redhat.com>
Date:   Thu, 16 May 2019 16:33:40 +0200
Message-ID: <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after
 failed memory allocation
To:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 at 16:59, Grzegorz Halat <ghalat@redhat.com> wrote:
>
> After memory allocation failure vc_allocate() doesn't clean up data
> which has been initialized in visual_init(). In case of fbcon this
> leads to divide-by-0 in fbcon_init() on next open of the same tty.

Hi,
A gentle reminder. Could you please review my patch? I've seen two
crashes caused by this bug.

--
Grzegorz Halat
