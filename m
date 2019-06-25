Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA152949
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfFYKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 06:20:12 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:54751 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFYKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:20:12 -0400
Received: by mail-wm1-f48.google.com with SMTP id g135so2203291wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=4gC840wcqb2NWmJlb40s55uXr+k2ykC6fzpFGRGyozU=;
        b=Bn6v7tL1wJNpigI8o6I8fND6sLjYVqe6WpC3dg/VL0qgLrgb2SlMG2E8JJIcbVI1Up
         GMvm5MoWz36C0Zv+hJqKLCCEUtoWRQUtET6WpAA0tDaJgRkuqWRBQl1m+5j9Y9hKVBCl
         Dmd8MalDRgbkjiEz9VKY6NFsQ4RQAsHmeOyk8tlumM+hC/7sR0nBD4nWTiMpZXJeskGI
         FIbxvOouxSGe1neHsoessOGN0sNu5y80NqJ4yu4/WY3QIW/nlmgroj/vDqUARjh5BvF+
         RF8vfBaZK5klrprq7SzOqTfSzcEHJRajjvj0na942lqOnWlScBMEiqC1WSeL7vHycjre
         1KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=4gC840wcqb2NWmJlb40s55uXr+k2ykC6fzpFGRGyozU=;
        b=oRpeTV5w7fFRFyWpOmFQhGRGj/H4t1IQ1Lzrs3WLnqCfCgrjPKob3A2nLAImSz1zPn
         49xXPz/wpQziBLO/XwyXts9a4UUqH1J+8tsq2MkMtytXXpPMNmDM2++L3eDhancMXpsc
         jmjJhbGvEV5TPkEC3xNRg9OM6Wu8RD5PBf8p4FRkD1Ed/S5qGuugJw9ByWWCperOOQQT
         AwZKI/5s20y2daxIupoEDjA+xn7qWCPN1VnH6lfWywZc6D7TJlQcvDzxRQSi7dOaCXp2
         8/PrZGlt71ibkQzZ57OgIOzrjOtcatzU9BOPaFPX50PZ4HxHPY8m2SisnnW9grRC93UE
         XwuA==
X-Gm-Message-State: APjAAAWJhJdpB0am5zEpJEVyhefB+thhRHQrtq9+8+XYAPMxrfTtkVNe
        0jvznj66BgiVPulYsATCjiS7dg==
X-Google-Smtp-Source: APXvYqy65uNNx1zphPMrpMFrTeLQwBSANx3Mc0V0kRmstE7bTID7UBTheh+7l3O/6vT1/lrHedFYkw==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr18869671wme.125.1561458010175;
        Tue, 25 Jun 2019 03:20:10 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a12sm9879061wrr.70.2019.06.25.03.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 03:20:09 -0700 (PDT)
References: <xunyo92mox9h.fsf@redhat.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Subject: Re: ebpf: BPF_ALU32 | BPF_ARSH on BE arches
In-reply-to: <xunyo92mox9h.fsf@redhat.com>
Date:   Tue, 25 Jun 2019 11:20:07 +0100
Message-ID: <87ef3i9dbc.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yauheni Kaliuta writes:

> Hi!
>
> Looks like the code:
>
>        ALU_ARSH_X:
>                DST = (u64) (u32) ((*(s32 *) &DST) >> SRC);
>                CONT;
>        ALU_ARSH_K:
>                DST = (u64) (u32) ((*(s32 *) &DST) >> IMM);
>                CONT;
>
> works incorrectly on BE arches since it must operate on lower
> parts of 64bit registers.
>
> See failure of test_verifier test 'arsh32 on imm 2' (#23 on
> 5.2-rc6).

Ah, thanks for reporting this.

Should not taken the address directly, does the following fix resolved the
failure?

        ALU_ARSH_X:
                DST = (u64) (u32) ((s32) DST) >> SRC);
                CONT;
        ALU_ARSH_K:
                DST = (u64) (u32) ((s32) DST) >> IMM);
                CONT;

Regards,
Jiong
