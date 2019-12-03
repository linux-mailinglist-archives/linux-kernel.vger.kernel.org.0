Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74992110488
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 19:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLCSww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 13:52:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44208 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:52:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id x3so3861162oto.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkhAW1JPr4wZMcoCAUkgxrDKX3tQPoTOxDYTCkC3waU=;
        b=Hjdnznllgz669BoJ6LQ0C+l+dL6PlscmUgAL1xpsNv/OaGjyoqdX7VSxhCQuBQ578j
         I8wBqlCTN8W3TPwmh0VjoFP16rkUV57cnrlQ6rmTM3FC8LnYDp2RFyJCeImcGS3luMQN
         5Pu14bEsp34hPT3kI0X555jj6yLIjO+w1v93OC6r6xrBW6ZD0k5NQJhT9WmTZxjzia0F
         xClTWg5I6rE0qu76U55V/jhhlQzMFDFm+p/rNQMM3r8N24Nil2ykHLCSojd3IJ5Ir3sz
         dSEbTT62wRkRO+leUKlpqJzb4pO7s+PblAW2no7YvZUBRXlG7NyK1Q/T7Jb3QsuPGAk4
         BXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkhAW1JPr4wZMcoCAUkgxrDKX3tQPoTOxDYTCkC3waU=;
        b=qTocXIDBgrkpj3reyKlWsLgEvZgSZ5BUfrk+2PwLofjG/qoorhLLO8yo+o4yzADdMp
         uY8IQWGVm96V9UfHAhc9zp9xMDjKjCHArqlD6LRzpYEjFGkneAV6Rxca+L//Z2+ND44y
         whw7CdHhMJ0fVOxA2OJDQ6dQbCpLC6237i7Ixl9lvszHKAgZkidcAqgUGvLPy4J2lML+
         +/M9k34CRHd9ghPeA3aKBwlRvfJaNrvrdsFK9vy0QbR4ddAkzbzYQ8uRbzHQlNj0+EFk
         x0BmSEkS8keY8zLczKUXrGCk/8b3LCeVNJA56Eq89qx8KV6PwiNT319JeFbPiJoGtZTH
         eXvw==
X-Gm-Message-State: APjAAAWfjkI11rFnShEhjGP7NQrZgY4L/QAPJrNx/FG0cWcKDPAmmCFk
        2BToGRE5xQpwZ0tusmNRP3k//Y/tcapyfSStQrZ30Q==
X-Google-Smtp-Source: APXvYqzs7Nq2HrpEsJ4z5tKrIRIy0SlwXh4gQuwIAJKfRwUoQoon8oTcC/R8n/ASFFf8Ve6Wlkan1uzWdKSQKA9MBuI=
X-Received: by 2002:a9d:3af:: with SMTP id f44mr4158036otf.332.1575399171204;
 Tue, 03 Dec 2019 10:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20191203121013.9280-1-will@kernel.org> <CALAqxLWbswQmLYJa_ODUDC0XJ5u=y_Nn074qcVAh1HZiTLNy1Q@mail.gmail.com>
In-Reply-To: <CALAqxLWbswQmLYJa_ODUDC0XJ5u=y_Nn074qcVAh1HZiTLNy1Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 3 Dec 2019 10:52:40 -0800
Message-ID: <CALAqxLUupqjxqWVs+Ei0QkOAWmQt7CEq-3LQsq3mzW9dFNDzhg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Fix initialisation of DMA zones on non-NUMA systems
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 10:47 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Dec 3, 2019 at 4:10 AM Will Deacon <will@kernel.org> wrote:
> >
> > John reports that the recently merged commit 1a8e1cef7603 ("arm64: use
> > both ZONE_DMA and ZONE_DMA32") breaks the boot on his DB845C board:
>
> I've also tripped on the same issue with the original HiKey board, and
> can validate that this patch resolves the issue there.
>
> Tested-by: John Stultz <john.stultz@linaro.org>

Also validated on db845c.
Thanks so much for the quick fix!
-john
