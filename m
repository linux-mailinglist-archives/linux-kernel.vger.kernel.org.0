Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCD166589
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 18:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBTRyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 12:54:45 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:45014 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:54:45 -0500
Received: by mail-lf1-f48.google.com with SMTP id 7so2324623lfz.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqMQTNTqAScrbbjAL00quzcLbXeMUXLVbynXt4e9wxY=;
        b=LUdFldegpwqvpb6jUZ3KgoQ8St6ComRy2Mt0QI/Aro5+InOuut6omXAr9nQF3o2TGT
         t8Rje9zNPB+Y70s2ziwN6pzj+GBEpkV/rj+BJvNjdp28MIoeLj+1ryQVtLHF44L1cElj
         Fdmcu69yfiRlkdgybwGqgcdsYCwE0oNwuTzqYSVh4hXy5w1LwfsVrzdSuetsLJ3bp19V
         hcU3wPT47l5uUfH5g7uN61Kbwnu99/puDW/sAY+BQHCP2flbDaG/hTysnOcQcpaznGVy
         pTNhgGAGraAd+K2mXoQ4sfXQO/MBsz3Cee7NH71g9WoS+6nu0/qKW7/EQ9Eu1DGgnsoT
         Dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqMQTNTqAScrbbjAL00quzcLbXeMUXLVbynXt4e9wxY=;
        b=MbvinDgq1wX0QG7HwiLaFZz7SW1kKueRSwfg0YIsvdx2ayDo8H8fC5WUQjD35A3v2Y
         PLKkfYnXRclKlAUWAl4FfALJgh+tfHh9IKEIg8uZsYc1c7il8AF5UjBd+bezmwp1zC0s
         tC809PuVawfJzc8p4GEdBn0dh8C05cBHhT5C7Ed3tByAwTxRHRFhAsfUN+jck1vpOIlK
         wh5wc5ZDbP6BtY3FWMzvPSIg2/YVVNrIPVQWvWm5ka+h3U/yWk8ANXE0k5zsxmKGugSS
         c7wJjZvn/atpbRKBnto3M2xJzzfMRfa6cAlypZ27NkUvMP+vF0ofVMkKbIwF2MVmDvsD
         VGqg==
X-Gm-Message-State: APjAAAW/vTsyAdTAO6RA9SrNJHKmJ6xehIyfPggmnBVCPHUzF/4OqP0d
        Q8A4n8BmGBIlrfc/yLiCD71E3lJhHSxPcBPja20Cjg==
X-Google-Smtp-Source: APXvYqw4jx+ECCaEc3pF2ddqAmUhWLsxs2tPv4F4B0Csslzt7ukoQ1EBe4t/LuTxKaPi4aNtoc+oNcCIYcIDitOBvUg=
X-Received: by 2002:a19:6d13:: with SMTP id i19mr16812579lfc.6.1582221282402;
 Thu, 20 Feb 2020 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
In-Reply-To: <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Feb 2020 23:24:31 +0530
Message-ID: <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
>
> Try to restore the value for the cache flush timeout, by updating the
> define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".

I have increased the timeout to 10 minutes but it did not help.
Same error found.
[  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
[  608.684964] mmc1: cache flush error -110
[  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0

OTOH, What best i could do for my own experiment to revert all three patches and
now the reported error gone and device mount successfully [1].

List of patches reverted,
  mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
  mmc: block: Use generic_cmd6_time when modifying
    INAND_CMD38_ARG_EXT_CSD
  mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

[1] https://lkft.validation.linaro.org/scheduler/job/1238275#L4346

- Naresh
