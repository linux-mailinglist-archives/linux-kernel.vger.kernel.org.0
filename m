Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC81BBF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfEMR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 13:29:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34229 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfEMR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:29:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so18727005eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwJlqsMKC/jDBqQsyBEKgt5enCla/m+iqS9EplHy9DU=;
        b=iCig2h+4uNOZ5tNXpLFw6PPanUpt7JN85Bf2e8H79TI3pXW819QxxtHXkttMGpk0bC
         gySnrLVUIRdktTKDgZT+96VxJU+MVkP/2BPo4TpuEpCkFqs8Rlkff4EjYYoNClaTj+il
         GCAnuk0WN/P3UzBwxH4P96bhlrXBShPnLNlQqeyozsGzdIa1eJ/VppNy0fAYMYY0+C2A
         RY99CNEXPfxzllhu2xoCu2G+Z22QPbuGAHXgRLOEQnMjdMv5s5Q0P4LFAfRphyz++bEj
         ocJhu68NdOdQMCtvJo+Q23lhaQ5uUE02oICHQjQS3lUaYgTZYmOwsCzD3ckvkVe7bdo/
         oPEA==
X-Gm-Message-State: APjAAAWxeIqeu0kS7IvY5j3RArvONPxnFuJ9tZhf5Qcw4A+dtbgoUDr+
        //k4igKRIbCN5q4TzsfC729SkphVz0jw329UpQc=
X-Google-Smtp-Source: APXvYqzOgdg3Z+wJXh8+BIKWCLu9YAVno5hSQMtI1e/SznbRix7rLeKLRPShouG872Y3AaYl+NO+bPMdTZQZ+nnwAoc=
X-Received: by 2002:a17:906:8318:: with SMTP id j24mr10804860ejx.182.1557768569090;
 Mon, 13 May 2019 10:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <9f57786ba08d4d5e913cd21693aadb0ccdba72b2.1557177585.git.len.brown@intel.com> <06e134aa-943a-dff9-4d33-e0bc8449f284@linux.intel.com>
In-Reply-To: <06e134aa-943a-dff9-4d33-e0bc8449f284@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 13 May 2019 13:29:17 -0400
Message-ID: <CAJvTdKndJAkp1q2mf1mamgFns+b8q-Q_u0--TduoH3dpdPk6BA@mail.gmail.com>
Subject: Re: [PATCH 22/22] perf/x86/intel/rapl: rename internal variables in
 response to multi-die/pkg support
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:04 AM Liang, Kan <kan.liang@linux.intel.com> wrote:

> The perf rapl "pmu" in the code is cross the pkg/die. We only register
> one rapl pmu for whole system for now.
> I think it may be better use "die" to replace the "pkg" as well.
> How about the patch as below?

Fine with me!
I've replaced my patch with yours in the series.

thanks,
Len Brown, Intel Open Source Technology Center
