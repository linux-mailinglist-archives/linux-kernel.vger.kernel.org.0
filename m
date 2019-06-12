Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA642BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfFLQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 12:19:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39683 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbfFLQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:19:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so1787260pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ClrvBR7luWRL5WMJSDigCb6gda3pje9DDVmIRQSL3U=;
        b=PoylC1mUVh+mUugbhLPdcuFW+A6JfOOcNYhRf3HNICnRBhEEVNhvTHiHjcgVcfeaex
         OAPtEDvngGbVgEF6tGnD+6DwpGiQKqcLJnlbeMvONX0E/j0tnRviRd6RBBW1E8EWWYxu
         w4vymiYbu9JgIXmwvtL6yApB3BxbziH41fDWgu1Eb4PpdnMgAnx8r/5ekmhd6wEX48zt
         PYsbooPvGIJTi/1Rj0y8ln3sYcYG5KQqPSpKI8SRRGZV4KvFSEOgGSQcVM1SdXgXT909
         A4ZSEsDqaW00ZmENy/6ltPQQ6yKeCHC4m5S56N0wy9Ko8tnhwgQ5G1Szb5jSzMbFTKuq
         zpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ClrvBR7luWRL5WMJSDigCb6gda3pje9DDVmIRQSL3U=;
        b=oOxfXari5cue3JTueTcHzyklX6XxkMHbcc4BidGQrcWEqoWxHZSodU01TalLxcEiVp
         5hqyFmjycvUv8J8m+5sXh1lWhQNv0S6zw0db3aqOSvKC3lIhSvUTCrzs84vAuQVYb+aP
         Nn1d/IgMCP9IHlq7kaC+t39BKPgTAL7hvFf56/KISAKpTkuibM9uwKgIHi7hGeRJ/1jC
         XkTeaGSx5/4jwGSdWRihjrVZ2JDi7QiH26pymi0NjtyQ5USkoGuGBSXj/7EI7MvXewvI
         Tla5JMOQDPQ5htyRSIjHUULNjEMLB5BKpuyY0ZcCqMDA0HviZBKX4M67As2HcmeT/o1D
         XVTQ==
X-Gm-Message-State: APjAAAVQsOrhRcw4eRx8fjDf1ytQaRjilaJC3v9+HiWd8qreCNddTgBo
        +1K7pbWifIpHgxHIWRYBtCCw8YaoCz/zb2fVpDM=
X-Google-Smtp-Source: APXvYqxlaM8B2sBpDDfQy7D9lbtLA6Z1olKuDzz6Dsq0bplhYER46QRJz+x6l7DR05n7Igry8lykPdohDOwu+vIQTyw=
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr62306065plv.282.1560356364709;
 Wed, 12 Jun 2019 09:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190612155411.GA28186@davidb.org> <20190612161239.GA9155@davidb.org>
In-Reply-To: <20190612161239.GA9155@davidb.org>
From:   Andy Gross <andygro@gmail.com>
Date:   Wed, 12 Jun 2019 11:19:13 -0500
Message-ID: <CAJ=6tTpH0VcOMu-mJEz28B2a7-HEq0tVnDyP-JWJP3BDOU+NSA@mail.gmail.com>
Subject: Re: [PATCH] Remove myself as qcom maintainer
To:     David Brown <david.brown@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:12 AM David Brown <david.brown@linaro.org> wrote:
>
> I no longer regularly work on this platform, and only have a few
> increasingly outdated boards.  Andy has primarily been doing the
> maintenance.
>
> Signed-off-by: David Brown <david.brown@linaro.org>
> ---
> Resending this, hopefully with text=flowed not set in the email
> headers.

I'll add this to my pull request.  I already have an update for our
repo location in MAINTAINERS.

Andy
