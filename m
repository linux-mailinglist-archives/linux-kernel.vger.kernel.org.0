Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C179A2B31
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 01:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfH2Xw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 19:52:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43784 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfH2Xw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:52:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so2453173pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6oTB1dU146xuL9pK4Gwg180KU60SGC31jIorRGs7ptk=;
        b=a250Zfx3hOfWzOHrL5E2dEv/6jxRZA+JbksFHHqddgm0GXvE1i4OV0Ui/sUUwWq9Qz
         4sKMyiAb+MJUEMoErBcXFPrcnPtDT2GaH8lfEelAqVK5nG8PlK407kkkx6hvjFc6VoV9
         U33PcQmOIjjinVTDjaCccNNDE79eJ2UxQkEfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6oTB1dU146xuL9pK4Gwg180KU60SGC31jIorRGs7ptk=;
        b=NHSxRhCg0C5J4mGbagLiKZYrWR4/s2fLsVO0O1HAYNL8SJQH/K0Ve9tRSeF0SWp01K
         w7ILi6ERKc9ONDamoCv0tFhe4IdFp4OQQkBW5X9QpMJVLtBPgfxNEBhN4nvlovQtasAf
         e972j+IDAIhOuDwkU0Ndh5qeLsth8kUJ/XFLyed3DZXvhvwkNkUsDagBs/gVxFbK5dIe
         iHJEV+aLx2Tgqebmz1hVmQ0NOQj/Xwrz3wyx/vEQYFwXGutOnWyyjB2fVVLbR9Knq+SC
         h2PoxBcutNuMtvPOsOI+sVDroC+CMjQwkHDg7uW3yv9bwV1p3TxyO8aLJ7ED8xQ0pwyf
         ugWg==
X-Gm-Message-State: APjAAAXS3YAqu4iwqawWwbXeaEAkLo4lpSKYMsbpldvojMfLO5D+Ozx4
        Tx0qEQq8emcqgHjkxJnIxbRf8Q==
X-Google-Smtp-Source: APXvYqwiOx/qe9a/xRLREIyTn3MhbFX5uD0lqjU79yaf26iwaXo0Rf6U2kBqJTeyMxYK5IrjN8j1aw==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr15134237pfa.142.1567122778338;
        Thu, 29 Aug 2019 16:52:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v189sm4473046pfv.176.2019.08.29.16.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:52:57 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:52:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
Message-ID: <201908291652.46E2D65@keescook>
References: <20190729151346.9280-1-hslester96@gmail.com>
 <201907292117.DA40CA7D@keescook>
 <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:39:40PM +0800, Chuhong Yuan wrote:
> I think with the help of Coccinelle script, all strncmp(str, const, len)
> can be replaced and these problems will be eliminated. :)

Hi! Just pinging this thread again. Any progress on this conversion?

Thanks!

-- 
Kees Cook
