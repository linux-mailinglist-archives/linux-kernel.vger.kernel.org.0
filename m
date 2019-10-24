Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5CE3A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394101AbfJXRyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 13:54:31 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44987 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbfJXRyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:54:31 -0400
Received: by mail-qt1-f173.google.com with SMTP id z22so18629118qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6T+qCgGucRisj4W/B+UwQyHmd5qcB9+VcC3830CVDpY=;
        b=WS/BXDVTI++B8O7fi7erJ1L/ZBtQvmdGVvFrViMs/FShhiYjKLYmb6+lxMS5If806Z
         abEsm/OiVlWAb2bfyAa28ZpFPjtb43r2LE7LO0XvWUzmJvJyWBCUELqEw0xusbTUGaqu
         3kgfXGbSBV/3huTKha/sEFMaLIQQoA2hU+r1hO1NZztxc44gg+99lpnF+31fKlFgcnDc
         pMEVoEMaNR5tbTzgmG40NiP5kt5NKGduHxdORmPV2sn1oymm9QmaZ6V5KvD7+omuWQFz
         pK7GRaZueJWzvGfo9JKsmDKvXMGRdSu/nHJriI8FImVV6jPxR5TxPx4XduiLTk8QPE2V
         Zcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6T+qCgGucRisj4W/B+UwQyHmd5qcB9+VcC3830CVDpY=;
        b=miBuM6tEVBlujsKF/96GFiNthVO7INewaCRhkAsQQuGboi54EpNGLBC7aNE6bg5XJZ
         AsRCYwnykMgTvuZfANwPSHpPZrbgGJrP8X20xVRAGOXKQnqwUsCdjPts586zFQ0ufIt+
         RXjk/N+IOy8RChwYk8Loc6LVEEE3ImTb+Zv17xVg6vzJc0g2UPcYU2fOR73q9S1EB5q0
         Ag+06A3Qt8PzimAz2P0Bk52apPVE+S34Omt8eJzNQJuPSV9HSSTrRVeMBbLDfRIaVM6u
         sFHg/l+CG2Lvqg/X8Y3yazaTaIPhry8z1oY6QDwHNnwGG712padciObg3FDlTFcq55pF
         NCsA==
X-Gm-Message-State: APjAAAXgk4T99yIXqRqa/MZjC1Jw3Akh1N4SPLvU/ePpBn9WuGIu+3mY
        X7NHy1D0wALxu2MkVQBCvcE=
X-Google-Smtp-Source: APXvYqyZUA63PKGUib4fzZH2qeHaP4Te6TZVtu7UZDrZJ88Yhi7bxhNJ+MR/JWxzkOutCNgbucp9WQ==
X-Received: by 2002:aed:3c24:: with SMTP id t33mr3269933qte.186.1571939670105;
        Thu, 24 Oct 2019 10:54:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:b2e])
        by smtp.gmail.com with ESMTPSA id x6sm12205125qts.37.2019.10.24.10.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:54:29 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:54:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: cgroup_enable_task_cg_lists && PF_EXITING (Was: KCSAN: data-race
 in exit_signals / prepare_signal)
Message-ID: <20191024175427.GC3622521@devbig004.ftw2.facebook.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021142111.GB1339@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Oleg.

On Mon, Oct 21, 2019 at 04:21:11PM +0200, Oleg Nesterov wrote:
> could you explain the usage of siglock/PF_EXITING in
> cgroup_enable_task_cg_lists() ?
> 
> PF_EXITING is protected by cgroup_threadgroup_rwsem, not by
> sighand->siglock.

Yeah, the optimization was added a really long time ago and I'm not
sure it was ever correct.  I'm removing it.  If this ever becomes a
problem (pretty unlikely), I think the right thing to do is adding a
boot param instead of trying to do this dynamically.

Thanks.

-- 
tejun
