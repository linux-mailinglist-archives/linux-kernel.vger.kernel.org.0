Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7246A0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 05:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfGPD00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 23:26:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37573 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfGPD0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:26:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so18430101ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x80Alcq+QWuLA12EET8W+QOr+ifK8yYftwPVmUXZyEw=;
        b=If6JTvulUIfgG0o9lo8LdCq86Obd5Tc6qQ3JZQyrL0sbGexsSMgRgXtYnJCoahiTLH
         VME81xwsA3kye1hahtF+bUNVh8vXPfLtM33Knh401XFpoyd2z8h4pm8bWQS9XXtdG1KD
         CmGRRXzKYcbI7+Ko1K9kF/IY4QFJ4tZpDQekc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x80Alcq+QWuLA12EET8W+QOr+ifK8yYftwPVmUXZyEw=;
        b=M788kVXTxWC7ZE15DJPUBPNQ7M9CVfUHXrT6as2wGERGd2b8iwQBk3PQeTyCl+t5v5
         98ONeiv/11O/PDa+5iLNt6TUFHpq/QPRcLjo0DrVy0vcttlS/cRBduSxHYpzDlZ9ImyG
         ZeTmHhDFmJDzaQw4ms+Aui8rVhTVLgOOUl3TGf5bt70a6wu7WcXnUwbk5ScTsT+MXbHk
         hVSs7GaSFklFFtqCV7GmK0YteOPsZ+Egrd2+bHujGITyWYzk/RiZgv+XZTar2bTvuQ2L
         /5SVlKxLnkNfPLqaeGosWvfJHuqfYlrVFUj3XyRMt8oehmJwqCJH//xyeGwC4RwEuTVR
         2DfQ==
X-Gm-Message-State: APjAAAWN90zD7MAmRp1Tt6FddgsLaR1JqV5zOPYtYCtZ/zwZTFirwcrf
        rHJnxFEyGyPPa4uebb2wSnMQw76dPUQ=
X-Google-Smtp-Source: APXvYqwPf9DWbX7ETFUWaXEN2LeZBV95y/3FE2CPYzShkNZ7zmMkURVjDQK1DnUmbPC0MgBQLkS/IA==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr16471584ljj.100.1563247583385;
        Mon, 15 Jul 2019 20:26:23 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 11sm3446567ljc.66.2019.07.15.20.26.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 20:26:22 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c19so12524231lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 20:26:22 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr13293723lft.79.1563247581800;
 Mon, 15 Jul 2019 20:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190715080009.GD4401@dell>
In-Reply-To: <20190715080009.GD4401@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 20:26:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhEUNpOoT-M-J-8vEdj9X3a=vGn-sZk9OwLoi_9k7-ZA@mail.gmail.com>
Message-ID: <CAHk-=whhEUNpOoT-M-J-8vEdj9X3a=vGn-sZk9OwLoi_9k7-ZA@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v5.3
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 1:00 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.3

Hmm. No such ref exists.

I can see the "backlight-next" branch which has the right commit SHA1,
but you normally do a signed tag, and I'd much rather merge a signed
tag than a bare branch for linux-next.

Did you perhaps forget to push it out?

              Linus
