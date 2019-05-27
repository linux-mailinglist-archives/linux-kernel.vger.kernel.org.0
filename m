Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2882BA29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfE0SdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 14:33:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45105 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE0SdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:33:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so12455262oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+zfvQdj9FnUsclchCusxb5xJgJGQtK3Vq/yGcWOHbM=;
        b=Qwju68uT26kSUsNGz9ECyX/QmQIUYdN0bXLJQ2iqz9YUkr7O0pMNJQfbARhG4gw6/Q
         KTobXi+lze+W5BZKejwZx08yynKbyloFDgDk/VGCKMER+VEmJ60guYTJb0GHQ7MFCdkf
         x+Rbun65sC8s8UBKooH8StlKmW18EcM1P3ctHRETKl0NLrG2BckZU7cqNCEQAkPGJ5xj
         G+Hxde8BLzqNS+CRaaI6e0DFnfaj7eZZ/PYVxbkhdmKi0Maj7bfVOOtVuOEnZ/Cs/Sey
         AGm7NAle/1CeA16DmFkAtWXxN+c0yxxJN8oeRaUJZq2vksaws9kf+Tuyb3HdJAVJXclz
         EUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+zfvQdj9FnUsclchCusxb5xJgJGQtK3Vq/yGcWOHbM=;
        b=SZwIu08VkT7Z+oyzt9ZwzuSZAFL/8y+Z66SFfN4SOSCXYF3vrcww0jKwwiEutrOrpV
         lnfhDEtHcnuMLvCA0G8f3vLbaEsk2F7wSZKxHMrQtOnmFffT40TdqgsDK0cD7uozHCES
         wfaeq2QeOf6b62dIaoyoJ1AigLXL0bY380BAZft7+GRd0lKoZE+HCw+FNFyT0dpf68PI
         nBN/8UH8117afYx9Vm5XQJyoUQeVoT/PfGf+Ur7Hd6IsQGCduaevQZPsV8O52rFLOMAk
         TJgyQDvOtx60g13/9wSdWwZ8oGRPT1Sr3MP7HPWwNLKYL70hvcxwlGA3SGZIQguos08U
         iO5A==
X-Gm-Message-State: APjAAAU6kPAwQyEsA6GfWvriaAydw7/69e2dbACkAX5NRsllk7668dqP
        UEsxtd/6Fu0LWQUH23QBZNg07dWuv6FsYT7VYkY=
X-Google-Smtp-Source: APXvYqySfT2vqPTVM4SYEzWI5e34ATqeldWvpzGysG2wnPt7WXQGJZSA/rBCSZvvFctmaav3G5VWvp/bJDDNojbX7Oc=
X-Received: by 2002:aca:3545:: with SMTP id c66mr199156oia.129.1558981990179;
 Mon, 27 May 2019 11:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-2-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:32:59 +0200
Message-ID: <CAFBinCBhdJdHzof0jmy65GHnQi6b8A+tmBUvhZJAf_Nbw1ADvw@mail.gmail.com>
Subject: Re: [PATCH 01/10] arm64: dts: meson-gxm-khadas-vim2: fix
 gpio-keys-polled node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Fix DTC warnings:
>
> meson-gxm-khadas-vim2.dtb: Warning (avoid_unnecessary_addr_size):
>    /gpio-keys-polled: unnecessary #address-cells/#size-cells
>         without "ranges" or child "reg" property
>
> Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
as well as:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 +---
there are more boards with the same "problem" out there
we should clean these up at some point as well


Martin
