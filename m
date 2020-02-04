Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF9152239
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 23:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBDWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 17:07:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40991 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDWHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:07:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so13334427lfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OE7fkKCLMto6NerQgkQtEvSNImJtUAlQc4A49qSBAVo=;
        b=b8RsIByYH8kijYJwSsPvxVSEwm8cGtvywbwpqvWqXmTgkaP0N6uhskkeoddAgemo1b
         HgtrnvQmfpX5AuLO9VR7O0gmm9w4JOsX/7xG11LV3HDLxyeeXDssC3NJH8JQzQ9A6f9m
         s0jxnwb8m77FJM4rJQeCMncqpMOPzPStRZ9cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE7fkKCLMto6NerQgkQtEvSNImJtUAlQc4A49qSBAVo=;
        b=OUxwyuBypdCJtZS06q5B4FGNCX0qzFV4mNE4vozADVdJbHBPm2MmGItqSlS6SRVtON
         cONClaObHIyP3Z/irpPbCYaNVK2+lLW284POJnu5B1+10Ow+2cZx5vrjq+WZTrrjFXk4
         t7A7PFx3CnUZCUkZvMERhcqF3TpYvjCkAb+nODZktm4tpbUq/Vt0yCgVwHZFAqw0DiVj
         FL2pHCFSkShpWfdNHpOqoum/Ff/PQWVutbN0MfdiBXOYMCH6ulbJK1JFH3vbJo+YqglA
         FrPy20Yigkn32zBtm4zSTY1VbDk9XnY1yfpiCG8wybVOp1DICfLLQNUEhiGL6AIM/NVZ
         7J3w==
X-Gm-Message-State: APjAAAW8VMk1SMo70XJzRKMXRgQs8mlMwyFM8CHTIry5r51yqO3tmlas
        7BaAROugdpu6JfJHMhQU9c1dyEU+zCagsw==
X-Google-Smtp-Source: APXvYqwX6dQNkfweSsqtYMapTmgh/dN0Twi/LUgoho2zHmkiuckSM5PR+quqUDvMTa5sGHD/+4iiRA==
X-Received: by 2002:a19:6449:: with SMTP id b9mr16071243lfj.5.1580854027584;
        Tue, 04 Feb 2020 14:07:07 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f5sm11213922lfh.32.2020.02.04.14.07.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:07:06 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id y6so300331lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:07:06 -0800 (PST)
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr18847443lja.16.1580854026390;
 Tue, 04 Feb 2020 14:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20200204110446.2c2616cd@oasis.local.home>
In-Reply-To: <20200204110446.2c2616cd@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Feb 2020 22:06:50 +0000
X-Gmail-Original-Message-ID: <CAHk-=whP+RHwN+h9fAE8LJk6m1f=B6G1mrnfiOSpZ22aJrwdCA@mail.gmail.com>
Message-ID: <CAHk-=whP+RHwN+h9fAE8LJk6m1f=B6G1mrnfiOSpZ22aJrwdCA@mail.gmail.com>
Subject: Re: [PATCH v3] bootconfig: Only load bootconfig if "bootconfig" is on
 the kernel cmdline
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 4:04 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +not_found:
> +       pr_err("config=bootconfig on command line, but no bootconfig found\n");

The error message didn't get updated for the updated command line syntax.

             Linus
