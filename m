Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDE156D12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBIXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 18:48:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43892 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBIXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 18:48:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so5039521ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 15:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qvl6TOYvLiKT8J0iO19pvnc3/hyeywMYYkZ/FlpkFQ=;
        b=OLTJtcXRacKws8QoDAKx/glLSqSXdvT1W+hLkXz2TVjhZjFEBccZqQXpw/casFjlBE
         iTo1DCzs7kEHyUFH0Ibq2XG9uME+DWZNKtUqZGgvTdC/D1kh5FNAkB4j7Sg9WSr7u4TG
         cCHLZqFU2QwM/4yvL0wLS1FTQi3aoc3XJVTBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qvl6TOYvLiKT8J0iO19pvnc3/hyeywMYYkZ/FlpkFQ=;
        b=IqVPwxSEk8iG6m0oIhzN7gzbU5EysF9lSain0ZH+faQC0WRiSiHwQ6bnZ2p9Jtlut0
         +sOja42CrqCCkeNXbWYVlF1FTJ/Ugc1N4sT1rvYtLLmlwcnpJLmT3lXiG4alEKOAKdEf
         UlMuloSv9cr+qNNNGk/XS9QRyzwpTd515gRXKYDRilJVQL2W0owP7Gi7WP0u8EZPivgc
         BHqMAYGeXU1djJ/J3K57Tby7M3Q6epXX6m0VweKJVxIhWvFGyq6ROqBSihk1WRCQBRHr
         iCK1B7Q6ObvyaeOehNRsyF+0al2pvP/0wI/5louPLyZZhg6G02Tx1vrDigHg59qLf3Hz
         PxAA==
X-Gm-Message-State: APjAAAXim6/xRfDwzCYdsm3QTWrdX5W4t4c1aRwkd2eeDb0aUXITOEiR
        xZyhC6ytleCCF0+7HTT8QXxzm+fSF0I=
X-Google-Smtp-Source: APXvYqw1NBKZEGrU4jdeNM7fWeZvhdQmGcaDfAH24g+BZDF8SDA/i71sKvhHgrlWBXZ0OloXtxLBOw==
X-Received: by 2002:a2e:556:: with SMTP id 83mr6201614ljf.127.1581292118376;
        Sun, 09 Feb 2020 15:48:38 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id k24sm6572923ljj.27.2020.02.09.15.48.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 15:48:37 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id v201so2850046lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 15:48:37 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr4737816lfa.30.1581292116618;
 Sun, 09 Feb 2020 15:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20200210080821.691261a8@canb.auug.org.au> <CAHk-=wiM9gSf=EifmenHZOccd16xvFgQyV=V=9jEHR7_h3b0JA@mail.gmail.com>
 <20200209225735.3c2eacb6@why>
In-Reply-To: <20200209225735.3c2eacb6@why>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Feb 2020 15:48:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZqek8X3DzqP69--vm3cn9EMGNcuOtDStALMuMmuA7YA@mail.gmail.com>
Message-ID: <CAHk-=wiZqek8X3DzqP69--vm3cn9EMGNcuOtDStALMuMmuA7YA@mail.gmail.com>
Subject: Re: linux-next: build failure in Linus' tree
To:     Marc Zyngier <maz@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 2:57 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Do you mind applying the following patch on top? It fixes the breakage
> here.

Done. Added proper reported-by (and cc).

              Linus
