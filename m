Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75605104483
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfKTTqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 14:46:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44101 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfKTTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:46:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id a67so523428edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxEM2vdt7/U/FNIfeuvzJ9elmjyMDsJD1vxaJ2fUtOI=;
        b=WrddtF4R/lFC853GKj7Dd7RzfOT6YpZ1GUF5a9E7wjXuFFN8MKM7RhIB+8Hs5fzeIg
         PcFZZAIgCLKYAM0nHNUvYyYGxu256OS+sFPtigA6OGKsKMr5JnUQ0TGVU9+fR0XKLGyR
         mHnkTW7EPOZ4+svqiLOsGNAL4YD33ESdZfLG7Zoi0uVp+z4FZwX8TMrPKP5sIDk3JFd3
         2SGIgae3CdqOVhDWxCOow+8hwjWUl5Iv6kOjWqWzDPnW3WIWfBE7d3n/ttyKSGN9Yjhs
         9bbUuW/6/OJp98x5NHd3iNS8ja+u68ErBXiEUwEp7zyjQzP1ODAlP+UwTaiXxZo9lMGe
         QDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxEM2vdt7/U/FNIfeuvzJ9elmjyMDsJD1vxaJ2fUtOI=;
        b=ubx/EVERS2XjWf8M9tHmeXpQXJreccMf7ONBnHnHxMS6YsWkfdNDX5nKM/UYyZxO1a
         hE2JXwbpW9D11AWaSkY7iYU1wv/1TjbmovSG5FlZzTjgymxjd/c75et3f63chRTozAjw
         sAEYOxzwLKcd7jQJTXbqpSqrbMB9eTeLjW+kn2+Z88yB5nf4oSIU4xMEVoBPKdFCH7TM
         k+8gVoYm63weL70wmP6d6rDDRHZL7Bx3vdbPBhgO6b0HOPUWIxjeH2bVMLHs/tEakrZ4
         xFZjXcX/neqlSIivbW8n2zznkIBgR+9zG3Dh0IsHgVUdiqt3AniL2Bo7734NZfFD3VZ1
         B5pA==
X-Gm-Message-State: APjAAAUDYNrjixfnUvjWwiHWhWGovxM99edgAdKzQjd8zJm+CsfbGQG0
        +Z/MlW1kyuSQlx5BSTWOz7PkBFxtMU1+M2ADcGNlWA==
X-Google-Smtp-Source: APXvYqypnvAPJ++PLYZ2U6aQOk5u/YILYozemKYHGTd1uN8FTstQuqto4KVAyP+G64ayeIzD3lKig4KV9XKFgV4HkNM=
X-Received: by 2002:a17:906:b30c:: with SMTP id n12mr7405055ejz.96.1574279206840;
 Wed, 20 Nov 2019 11:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20191119221006.1021520-1-pasha.tatashin@soleen.com> <20191120191648.GB4799@willie-the-truck>
In-Reply-To: <20191120191648.GB4799@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Nov 2019 14:46:35 -0500
Message-ID: <CA+CK2bDeXP8iUYF2GC=9PttTug1E66=z0h4PSGBn3Gr5t3NHzw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks. I've pushed this and your other patch out [1], with some changes
> to the commit message. I'm annoyed that I didn't spot this during review
> of the initial PAN patches.
>
> Will

Great.

Thank you,
Pasha
