Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA924DF6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 22:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfJUUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 16:30:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34601 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:30:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id f5so3463648lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/aJo1E7eREpKm7EO70VIocrVlE4tW7/8DSac8YG8gY=;
        b=DOW6tu8BKZyBezPVNCnDyJOpy3ezSNMvTUqo0KWSvLMhip+zVT8SICkxZP/jsB8Xgb
         RCijqkmYHhiiehSWrhMiwpXdiWS0mo73B5NaH3GdhGcG2TEOHGDsAzEztR4FKnKBY9XR
         Ow93HejyFLU1aCCBOm1YKVlIiABXcunByQvCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/aJo1E7eREpKm7EO70VIocrVlE4tW7/8DSac8YG8gY=;
        b=CYWJOtUSTT7qIdXbSmDjDRbgx2GUiBaHCDu+vTX+8HvyhO7Y9kkVcURRoV4cGX9oQ5
         31evjNjOMXj9CXVY9yMLv8MoJGaOMg9LwYOt5gWj6w3MnAZwo5YyhVL/ZPcfOl7NzggP
         kaFpoetQ5TpH0gej1v5JQYOJfX45HpyCiBz+lGB1ATA5AYRdzG8kf2BBtB7nLEOjQS5x
         ZyJNB5fRkxkXcPVITPoQDH43manl7W89hQVaUquoG/RAwUM4iJc66fNAaMBmj5TzBHk7
         6TBL7HquO9ikF8ooNBgjgrxeC8sOo+BBIxZdzbDP7CdhZZ63m1fu3YVquguhp9xhDvEM
         DQdQ==
X-Gm-Message-State: APjAAAWJY/gaytPiFFb7Ld/q2gU3I77+o8INjgm5FG08c0CcyF6XIfkD
        w7BF2kdQFw3ObsP3rLAJX8cYAG+fzZCqpQ==
X-Google-Smtp-Source: APXvYqy9FQnGJuTmdvICjQsFqSPFAh0mlBe2+SZbC4B7MHZgCJxt+vu5RnqCiQLuUM2OTfpoIIvr9w==
X-Received: by 2002:ac2:4248:: with SMTP id m8mr12241531lfl.94.1571689848351;
        Mon, 21 Oct 2019 13:30:48 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j2sm6798653lfb.77.2019.10.21.13.30.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:30:44 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 21so2234332lft.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:30:31 -0700 (PDT)
X-Received: by 2002:a19:820e:: with SMTP id e14mr1151478lfd.29.1571689831813;
 Mon, 21 Oct 2019 13:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191021124508.203ccdb3@gandalf.local.home> <20191021151348.3a231f04@gandalf.local.home>
 <20191021151934.50342fef@gandalf.local.home>
In-Reply-To: <20191021151934.50342fef@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Oct 2019 16:30:14 -0400
X-Gmail-Original-Message-ID: <CAHk-=whCRAsQTKkR88bUgZ-6ET45U++47V=8L_H9YGCk7n-U7w@mail.gmail.com>
Message-ID: <CAHk-=whCRAsQTKkR88bUgZ-6ET45U++47V=8L_H9YGCk7n-U7w@mail.gmail.com>
Subject: Re: [GIT PULL v2] tracing: A couple of minor fixes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Prateek Sood <prsood@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 3:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Two minor fixes:
>
>  - A race in perf trace initialization (missing mutexes)

Are you sure you fixed the crud?

That commit still has a very odd commit message with an oops and
ramdump at the top, before the explanation.

             Linus
