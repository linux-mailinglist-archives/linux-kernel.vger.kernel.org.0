Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FBECB3E8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 06:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfJDEcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 00:32:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34350 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfJDEcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:32:21 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so10774287ion.1;
        Thu, 03 Oct 2019 21:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2nPEB8rA+jsS1ttiFP8H7C3sJ9YdpuV2AmlRtnRHNE=;
        b=FjGXRHWSfuV14PudxoZgKdFd8ltv961tGHcnbLKmjsa/8Uxx+EWhq7bj6GRhk0Y2Uk
         cBFZsicCoqGWvpVrqOYFxpSKDDcmO7jxewrw3RTu6BUhrTknGYpky0aitsvBQD6E35Ep
         IjUzkTkmOPkaZusSeOV42d1j3ZS+H788zPtSxBPhOEZKhwkppVUXs8PMfjT2oyx5Zrax
         MPTxOZBpZDwGqQCwLXDeVZCfi/scdGmfDlobCyraMDumz3+n+zGypsIDJl1TpJt5jx/b
         sXoc8jC3of4xksEFXbAUVC/OozUWrHyqDxEb7+xc2AsXvV5XrMeW+vNoADWPiFneIM8O
         BdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2nPEB8rA+jsS1ttiFP8H7C3sJ9YdpuV2AmlRtnRHNE=;
        b=iQrAFtLvQVSIBF/ERmbJJiKm+9lSfnT33EDxlQs6E0qKMxqhSa77NDP1XMJ8uDqBD2
         q+NZyvNHI5OntOonshs7LHahQ9tHf0mOhScvMwuP3PvBpOlydNB4ECboGmkHpkktOKC3
         xHHjc5u5cbmHYPk3UvYhQzy3FyBGrt/WJsfhFk0uGVvFa6w5ZuYnlAKxyFlRhc4Keo6H
         t7uR992dpuia78XzkSa55wev7w2MgUNKxIPVnQ/ICP/eREV4AkYIO2Qh1g14HsDvVgFx
         rDUxG0Kj0ee1cvD1cWOg/R54dsyoJoLxF47x9R4PNMZkuQbLPSV7t1+U1N6ore+m4sLI
         9oPw==
X-Gm-Message-State: APjAAAU+TKs4T6ZB7i3xTJO7tLHyRb2dz3LZSvXxrhHkzoGSLPpsFZcA
        kRRufEVqtHZLEmTUKOzj+Z6EwbtVjlIlO9kGLEg=
X-Google-Smtp-Source: APXvYqxINY9ZmOJ0xUuloWso3ea+rJC4QHAazPL//m6xavj5isViQ/kZj9Vg0IapF0O5kPX2bKwnma2M8zAZrGTvqDk=
X-Received: by 2002:a02:245:: with SMTP id 66mr12608668jau.30.1570163540786;
 Thu, 03 Oct 2019 21:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191001073901.372-1-linux.amoon@gmail.com> <7hv9t5vi5d.fsf@baylibre.com>
In-Reply-To: <7hv9t5vi5d.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 4 Oct 2019 10:02:08 +0530
Message-ID: <CANAwSgTR5mnBLGSQcq6xj3yBvu6J1FDKdiLGfaVybtN6HqsAuA@mail.gmail.com>
Subject: Re: [PATCHv3 RESEND-next 0/3] Odroid c2 missing regulator linking
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, 3 Oct 2019 at 23:14, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Looks like this changes got lost so resend these changes again.
>
> Yeah, sorry about that.  Your cover letter subjects were quite similar,
> and several versions of this series and the previoius series arrived
> close together, so some stuff fell through the cracks.  Sorry about
> that.
I will keep this in my mind and do not repeat my silly mistakes.

>
> Queued for v5.5 now,
>
> Thanks,
No worries, thanks for the update!

>
> Kevin

Best Regards
-Anand
