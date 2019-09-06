Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F46ABCD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405116AbfIFPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:44:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38844 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIFPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:44:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id a23so4464458edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXzffckHlrDd2GxMkcUegpxPLxQbezYI5SKZXnOnJzk=;
        b=GOMgzAf/lkF5c2eKwXgjCw9a3KXnWR5APRE7h0mk6NdXu79AGiO8sODfHid9N6Xl5h
         M/C8KT/SLLU5H1Aqg4nwEKOuTu5OkbyrUQJTErU8uVcm673iUBJEH32XMXPStUacK9QI
         xCMSuQrJe1j8CHQBTWz9PB+Jomp1+g+QD9Tkd9KMYHmJWFzG5xyCzw8xyfNgbLXZwkrs
         5FlS9o5FS4p8okYBPzuG2ITgzJGemxFxUkm3aSbDG/x0MDmUmazIm6dOMXX9j66GMFk+
         3cLHZkaYpm/muQI+jLdcObCu1m/ydijbn1wGNoRDjuAv/Fx5CRGdTNnFLVIVNVPLSSN2
         qWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXzffckHlrDd2GxMkcUegpxPLxQbezYI5SKZXnOnJzk=;
        b=V8svtINDMGmdJhTKUfaEJt2Q33E2aEzijyMPGH7g/jR/XHYPgYan3kfZ/OqJjC8B2O
         cH60bD/E6J88kboNK2vXtI89m6uapzpXU/JYv6erZVGe4PiLJVge9zoXB8bJWbBHs3i5
         tmQfLlQJTuxV0pIgIF0/m6pg97ivmU6VEfhwki2CjiFnBcNmPqP3gl+T5yujSQZSjE5Y
         h/QWfORGFqDneuoqus39kp1eRw9s+6QGaV0W+u4YmVklLgssnaxxXm4NJoy6caK+De5g
         T16CjtTtnxCa2Rfcet/04+M/dTcDi+H9uKpTpQ3HNXAVYqtl0arp2AilVasl6LqPh/GB
         Feng==
X-Gm-Message-State: APjAAAUOc5BUnlZxwRQUYjpQpOZHDBCW/SCoikcWntX82n6fR+hVdOUt
        XXkTHElY3dwlS0NtjFF9G+oTuxMHg8ApoXJK8gp+qw==
X-Google-Smtp-Source: APXvYqwplMA0AW8lXkCWQuG9K8cCsGpwcuOwcj3r1h53xYTkZkNhYGGnMNAxboAR+e2euONipoiDRfZvyN8jJZQFWsM=
X-Received: by 2002:a17:906:f04:: with SMTP id z4mr8127839eji.209.1567784661783;
 Fri, 06 Sep 2019 08:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-6-pasha.tatashin@soleen.com> <ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com>
In-Reply-To: <ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 11:44:10 -0400
Message-ID: <CA+CK2bBXfa0MFspOpWAGL4Q7iYH9UMdKAwMD-PyL7Wp4s64x+Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] arm64, hibernate: check pgd table allocation
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > There is a bug in create_safe_exec_page(), when page table is allocated
> > it is not checked that table is allocated successfully:
> >
> > But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).
>
> If there is a bug, it shouldn't be fixed part way through a series. This makes it
> difficult to backport the fix.
>
> Please split this out as an independent patch with a 'Fixes:' tag for the commit that
> introduced the bug.
>
>
> > Another issue,
>
> So this patch does two things? That is rarely a good idea. Again, this makes it difficult
> to backport the fix.
>
>
> > is that phys_to_ttbr() uses an offset in page table instead
> > of pgd directly.
>
> If you were going to reuse this, that would be a bug. But because the only page that is
> being mapped, is mapped to PAGE_SIZE, all the top bits will be 0. The offset calls are
> boiler-plate. It doesn't look intentional, but its harmless.

Yes, it is harmless otherwise the code would not work. But it is
confusing to read, and looks broken. I will separate this change as
two patches as you suggested.

Thank you,
Pasha
