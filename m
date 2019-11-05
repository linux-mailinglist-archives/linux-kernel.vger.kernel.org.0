Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED9F075D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 21:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfKEU45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 15:56:57 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40505 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:56:56 -0500
Received: by mail-yb1-f195.google.com with SMTP id y18so2980297ybs.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIEezFFKIHZBj0qSHNs0T72Y+LVQQWgQjVNEg04TG3g=;
        b=Dk4fFb10y0gk0dAhcyVw0w2enKgSTy5WoXuws+jdqE/TqyXhmJ4aA1py4uAw/olu93
         w1jf2vRM9U/79p3YxoCRzs1wWkRYdtRvpL5tnC+Xx/3A4gf0nCGxk+UdDXF7leuP9UoY
         WJy8aCdkXspXIfx2cdyLeTSAJZStdL0xH79CL4xALCk74fJ9+50YXcFjBOVOmbfZHAMS
         yeAQgn8Xg5bw09TF1WnlXAPRIZDJn8rtMq5PprRcTOu7AWuk4tlX7Skp5NyKaMPITP3z
         hKqX9nOc4tklyxlw/D6AafGdZkz2SFUKd37SIR+BQi5yT2f8h0eB+BkAUxrL60ns3mJv
         5vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIEezFFKIHZBj0qSHNs0T72Y+LVQQWgQjVNEg04TG3g=;
        b=sHdA6tzife+ZF9HanXJqFIhcAXN+QpcKZm0gS10/7XxR/NNQ51kYKwc3+1BJ3UAVi2
         egX4VEOGn8EuQh/4G1UOCJG39VUnTigaoQdUGh0M/2gIUor9eiBs974Df6njh/LRVrEz
         ix0DO2IUKfgfoqPdwt+nJJbv5sYE57lAba0MZeIWOymIR0/TPK7r5Y2+rrJ6xddUWk/j
         FSua3kV6/gJGaLOhNdDErvkJMXfr2PlcnLxJ9suMdq1/RhzOr1YMCreb7rIBPtIkCsMp
         M7rAoTV5hehAeemZV9Ib5bBpHROI5KaD3SbTzZYdIrWk+CQNxi6Roq6i79zvWGUDyI0u
         Zliw==
X-Gm-Message-State: APjAAAVRt6qacfj0O9XquoLjXcnHVWW1mwkdwD6aYnjyvkOuzkmV+PLD
        CcHeN3Q/TLMbrTXSi7s/UY9Cm4dfbhAaMqga0sg=
X-Google-Smtp-Source: APXvYqyUeSk393TMjATq6Bdw+D36pMO9HxUeY2HUcaE7CoDwSt0VFf+sEqpqWnrbryEmZvofCbLqZx4QD5okO5jjpm0=
X-Received: by 2002:a5b:710:: with SMTP id g16mr15581484ybq.181.1572987415698;
 Tue, 05 Nov 2019 12:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20191105061510.22233-1-csm10495@gmail.com> <20191105152654.GC22559@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191105152654.GC22559@redsun51.ssa.fujisawa.hgst.com>
From:   Charles Machalow <csm10495@gmail.com>
Date:   Tue, 5 Nov 2019 12:56:44 -0800
Message-ID: <CANSCoS-tig6D2cH4KrG51ifS1cUSXqWiC-FccySgYznCVk3TcA@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, still new to this process.

Signed-off-by: Charles Machalow <csm10495@gmail.com>

- Charlie Scott Machalow


On Tue, Nov 5, 2019 at 7:26 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Nov 04, 2019 at 10:15:10PM -0800, Charles Machalow wrote:
> > Changing nvme_passthru_cmd64 to add a field: rsvd2. This field is an explicit
> > marker for the padding space added on certain platforms as a result of the
> > enlargement of the result field from 32 bit to 64 bits in size.
>
> Charles,
> Could you reply with your "Signed-off-by" so I can apply this patch?
> Thanks.
