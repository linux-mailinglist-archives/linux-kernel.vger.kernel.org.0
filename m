Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990611349F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAHR7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 12:59:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36622 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgAHR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:59:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so3347678edp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYI9BdokG2IbKyPM2CZW5USlC6MewEmU/EsguFiov3s=;
        b=hruQrdLyR9/6799NqXMaIG2kcPTB33SpTMDmQYiE6vp6kHoBE5stgW1MaZKyjvZEHS
         9pyrvpkV+NQv/kkb8q5nTz1tTLWuuT1OgqWGMyCl4SrNwKg/Vmk9/2G+WNkwGgezngDA
         FYKlRdEN8J3h19TIKwynRppUNImOq+Xhfr3fGTJ6sArPvEm4gpxNjaYPxhftTMoienYA
         2nOYAZHd7I0S2gi9MDvpYHkqCYX3dor6aiynnAumkuiKYfaz570phRxWWrlZ0pKSAcpm
         +DQBUyvQHCVPMUWbYH+7XD0ec/9hm9xW7UVxT/sAZIIw8Rb3pnK4QfV3hYqG7QqRiLen
         xJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYI9BdokG2IbKyPM2CZW5USlC6MewEmU/EsguFiov3s=;
        b=eKZEwyWb433dhgnePzjKeDmslD21IY0JBGezHDXdKvIuE24gzGdKhvtOY7xIVcYkAt
         LM25MkrDz8m/3GKSbP3ztt1Kbgcu3xXx0OcU31D0k5Yj3e9JVA8MWBXouUwQB0z/Mopw
         MTdY4LfxF+uP7OyiSH8C3CEzutzQ4B3MR5aJ7xF93W3alzfKgVSb6CN5UJf0cFKPfF/X
         4dX25qMGvRaCYbZO2OdfWYK1y6BG4ZEwtwIWAx53oOKGZFpvzK/4QhKSoz6Eb3xD6q9k
         7GigbiQFHQIMEuYxgP9T3WUlX8wsGfqFVNEisB10Uz2bBjbvFX8uedD5GiHna8xlKgYl
         Q5kA==
X-Gm-Message-State: APjAAAU/StJZxcIjh5BxPM0bARWmccpWAHzWDb0Qi2fuxss4T4IBsPis
        6xPY9KpwOmgybUCrW1wQTs8IYFuw0GvouHJ9sSjX7g==
X-Google-Smtp-Source: APXvYqy0z28/dzBrNsd91I0p0ovtGg4Owrd9cilLSqMFv+lDXxI4gLLHOwdGWBi7vzbaJVrwcuwcObUtdOg6AO/wMiw=
X-Received: by 2002:a17:906:4d43:: with SMTP id b3mr6268026ejv.109.1578506378310;
 Wed, 08 Jan 2020 09:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com> <20200108173225.GA21242@willie-the-truck>
In-Reply-To: <20200108173225.GA21242@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 8 Jan 2020 12:59:27 -0500
Message-ID: <CA+CK2bBDhF4YuFOeagzZ48-BigDmOVuBKZTAC8fd6tojcJN-0g@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] arm64: MMU enabled kexec relocation
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 12:32 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Dec 04, 2019 at 10:59:13AM -0500, Pavel Tatashin wrote:
> > Many changes compared to version 6, so I decided to send it out now.
> > James Morse raised an important issue to which I do not have a solution
> > yet. But would like to discuss it.
>
> Thanks. In the meantime, I've queued the first 10 patches of the series
> since they look like sensible cleanup, they've been reviewed and it saves
> you from having to repost them when you make changes to the later stuff.

Great, thank you!

Pasha
