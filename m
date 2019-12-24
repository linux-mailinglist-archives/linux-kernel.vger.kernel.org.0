Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEF12A066
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:22:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32831 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:22:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so17708914edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 03:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+JpIu3vYJU8a5Gq7Z5l9BFQkWLO3Nuw3pvsMvETS7c=;
        b=H2b2ofvx22QIFqPfWb/57Cgo4+6EYRM3UmWRLglTZC78WjixSKQRStrNRVkP41+J3i
         D9rt2R9ktslIGTdHcHmxVtFRgeRAodsryfwssz/uNBn9qP1aW+pFoeFzxj8r4J954YCj
         /9Bxje/ma4Hcq9VmUqFpcK3BtabstmdU11pb09O9By5MFwQUYXWRZ4hArq/sDJuE7e6d
         jdrO8GqEyfSdl6I/YpBFOU6Cr1beioNmDtweTzR+t8T59BJIq3R5aSjs+xiMhsdZpTOe
         vCcr70c7mVfdLY84kTlBITIgkg00wbxKAHZz9Ua63zF5lxS/qM7GVJYyklqRrp8PV5Bw
         RJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+JpIu3vYJU8a5Gq7Z5l9BFQkWLO3Nuw3pvsMvETS7c=;
        b=B2eL8I2v296ATwm5qyq9zOlcYVly+lgVo62TNBogPNHX+rzLpxNNLdMS6mu+t2Boqu
         RnQwoVLU/DVaWFz58Ik8A0hRHBk8TO+VII3zaW/RrJIGzgn0uLDiDBV6sHuaz11aQSt/
         JXOebJVX6u3ppzDTDeoNIbvQa4y3dlkVOfnGrfVnBBsb7FXCLgT929g8d/dSpVb+GGbn
         LzPVudn2ldtMamIhrqNEnncquX2NhpJEtJqfzldyKB8+t2wwSr1RaL+uTpBID/aosW0p
         zltbOcFsu9rmbVCUyZBj7DUJdQ8BiEJasOxkmg9HNdk3D3tZOZrG3BMPtherzdIHF4Ke
         9Z+Q==
X-Gm-Message-State: APjAAAV5LKsYRowM0JHT5XAk5kbB9i3skJbbZXPx6CETrLYYRafE8KSE
        Bf5KZabayqqpTOoMIPdhDgs0Tsxd58SjK/n3MsI=
X-Google-Smtp-Source: APXvYqwpjloweDhJk9K1WbRoanlfiA93jPFsGS8Fs+PosuYx6ygOY/COI9WSyi+Vw5n5/quxpcoKFqWqpEy093u1djo=
X-Received: by 2002:aa7:d6d1:: with SMTP id x17mr1784678edr.57.1577186540180;
 Tue, 24 Dec 2019 03:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com> <CAKGbVbvj5zK9gVDQ3+0=xmF5pOUOSJzZ6jaGKHoCqwjYz+UiEQ@mail.gmail.com>
In-Reply-To: <CAKGbVbvj5zK9gVDQ3+0=xmF5pOUOSJzZ6jaGKHoCqwjYz+UiEQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Dec 2019 12:22:09 +0100
Message-ID: <CAFBinCD+k8O90ePuwSEnW1+oh-xJ9oUC5P2WrHgLLBb0RHj+=Q@mail.gmail.com>
Subject: Re: [RFC v1 0/1] drm: lima: devfreq and cooling device support
To:     Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 3:51 AM Qiang Yu <yuq825@gmail.com> wrote:
[...]
> For the code, I think you may need some lock to protect the time records as
> there are two kernel threads gp/pp will try to mark GPU busy and several
> interrupts try to mark GPU idle.
good catch, thank you for this!
I assume the reason is that the panfrost GPUs are using a "unified"
architecture, while the ones supported by lima don't

I'll add locking so I don't run into trouble.


Thank you!
Martin
