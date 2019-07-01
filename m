Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236901BBF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfEMRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 13:30:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42074 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfEMRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:30:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so18691522eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KHrVjOJIKdAkwrfnTAw3fqu9992hX+XQlQ2QX6Un8k=;
        b=rL7i4rZnSN7KiY0C8uSURXLuvV0y5sU6mr8oVqS/TVXz9Un9BGa5QROe2KXaUwtVs6
         vTx57HJpEa446ZHGLPIqd6GadQyhIp0RAjja3w76Y7mixzjCvSMULjtxLl6SO9NsBqf/
         7DnHLbdWDFiNAzrQ7wUxg2tG2WnKbFRnAMVKfsnUxVkRv3yM+a3A77oFoMt+M3xr6Ir3
         s6dRn/wv3WffLC6F54ezvrqORWm74Ybys0Q+P+gEW2sFnGyeP7NI/e8B0X3r+HmXuDyt
         aaJpe60iganN8Aoav3CMj4thCCdqycIZy1/X60dD8QKu8zcsTbK+KCGhRKaMTNsDq1Ln
         58/A==
X-Gm-Message-State: APjAAAUwRBFL+xxUmJnl7j/5A3RqGnT7tIDJVMzIFOZVyHKeRzhbSjhz
        C+xxvA43vm1MJ6Hc22G7vNZXG7CuCafxxZSzWeI=
X-Google-Smtp-Source: APXvYqz3oM4dVwEL3Z4or3ot8AjgF3yS6/CtEOpPWhmoHuOpZkFf7CiRlv8SMfATlSur7WhDOL6i54/HdMOy9+LVDT8=
X-Received: by 2002:a17:906:4c90:: with SMTP id q16mr13150005eju.297.1557768653238;
 Mon, 13 May 2019 10:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <a1ab2f32d8d99f0561ae5e2ce3337d48f1b6f66e.1557177585.git.len.brown@intel.com> <aef058a6-cdc9-cd86-cbba-ff96c59ef84d@linux.intel.com>
In-Reply-To: <aef058a6-cdc9-cd86-cbba-ff96c59ef84d@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 13 May 2019 13:30:42 -0400
Message-ID: <CAJvTdKnS+zAHE26NPq1KY6AfQkLd-Tyeson1-esnf+5EX9+xtg@mail.gmail.com>
Subject: Re: [PATCH 21/22] perf/x86/intel/uncore: renames in response to
 multi-die/pkg support
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:02 AM Liang, Kan <kan.liang@linux.intel.com> wrote:

>
> I think the "box" terminology in perf uncore has different meaning. It
> stands for an uncore PMU unit on a socket/die.
> I think it may be better use "die" to replace the "pkg".
> How about the patch as below?

Also fine with me.
And I've replaced my rename patch with yours here too.

thanks,
Len Brown, Intel Open Source Technology Center
