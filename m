Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77BD10DFF1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 01:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLAAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 19:40:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37748 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLAAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 19:40:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so8424835lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 16:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5KsBUM8JPybDXiUpn5VQxvK/h7+Y2vajWRzHP60FL4=;
        b=bMO4gHAAReaAa9vawpWAqbJqwziS8m4F59UGT7LFZBRbuY/+ZXOd6zXE2VmTjpeFcD
         csNKArPGBeAixXoAgRRYNBjq0OZWH8+6jfBXW7dOuLt6okhMcuEOB2bJYnPup02YSO52
         qAJhlQ10rVZXIue3kNBcXrCAzqLxtniIcRGPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5KsBUM8JPybDXiUpn5VQxvK/h7+Y2vajWRzHP60FL4=;
        b=I/3RnwDVIxKMLnz+3fAA0f75IMqfcKReDssfJgEtyIChbNcLgqfitw/swopE0kf2ky
         tWKj5ddlWLKcOVBWgWZzU2Zo2ZZqVR73Q5VwdCSMzJwaLd5HuhDru+1wuCTLJ56oerSz
         XAy/uhsXIB9SYrnsMet94tgtLaJuZglD/UEBz7Br1auSw2S0SGckOyW45mrmI4BxAjuF
         5oVJifnRFPe079cV0ZcEzw8UH2zt9f72C/rmP3yEQThYmcLFhBPbG7dJk6XcY1BD/xDN
         7ChJRik0VjuVnBgezijErGe43rfmu4plstzETJo4oDmR1txBWCu+TaaQKsLE9vk2S5OB
         8SYg==
X-Gm-Message-State: APjAAAXl8Yj5/uFKT7MkIB6Gpe7xGlBrVjFJi37retiUrqt1qqlKEvb7
        nAhnFlXgYNfqBMMEL74YEE5gCqWzxaw=
X-Google-Smtp-Source: APXvYqwgx0C40WTXX7UqSYjKwP86YYYdjQa9IamgiGEWHyH9eZlKwVW7eJiAWxIPcHm++pwpnzrwvA==
X-Received: by 2002:a2e:a404:: with SMTP id p4mr26937623ljn.234.1575160853528;
        Sat, 30 Nov 2019 16:40:53 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g26sm1976802ljn.89.2019.11.30.16.40.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 16:40:52 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u17so8424784lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 16:40:52 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr27980802ljj.97.1575160851969;
 Sat, 30 Nov 2019 16:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20191126093002.06ece6dd@lwn.net> <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
 <20191130171428.6c09f892@lwn.net>
In-Reply-To: <20191130171428.6c09f892@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 16:40:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrRu1BB+GRXn+k2oEWZHm03p19MnQqbSfgn=mMiWnCkQ@mail.gmail.com>
Message-ID: <CAHk-=wjrRu1BB+GRXn+k2oEWZHm03p19MnQqbSfgn=mMiWnCkQ@mail.gmail.com>
Subject: Re: [PULL] Documentation for 5.5
To:     Jonathan Corbet <corbet@lwn.net>,
        Git List Mailing <git@vger.kernel.org>,
        Junio Hamano C <junio@pobox.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Background for Junio and the git mailing list - Jon's pull request
to me had a lot of whitespace damage from CRLF line endings for some
of the patches he applied. ]

On Sat, Nov 30, 2019 at 4:14 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> So my tooling is "git am", nothing special.
>
> All of the afflicted files arrived in that state as the result of a pair
> of patches from Jonathan (copied); I have verified that the original
> patches also had the DOS line endings.
>
> The problem repeats if I apply those patches now, even if I add an
> explicit "--no-keep-cr" to the "git am" command line.  It seems like maybe
> my version of git is somehow broken?  I have git-2.21.0-1.fc30.x86_64,
> FWIW.

Hmm. I wonder if the CRLF removal is broken in general, or if the
emails are somehow unusual (patches in attachments or MIME-encoded or
something)? Maybe the CRLF was removed from the envelope email lines,
but if the patch is then decoded from an attachment or something it's
not removed again from there?

Can you attach (not forward) one of the (raw) emails that shows the
problem and keep the git mailing list cc'd?

             Linus
