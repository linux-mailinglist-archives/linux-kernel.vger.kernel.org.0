Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC13181E06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgCKQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:35:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39884 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgCKQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:35:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so2290333lfk.6;
        Wed, 11 Mar 2020 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Apgq15pxlwWxLUmTSPSMXlMpS1SiDrgxMaLWg5oKw4=;
        b=iCUUSIYXrTdvEwEQuE7ljtux9VNVWYlge3Idal5FHEIPrt0exwyIMjhJWyu3kr6uRI
         wPJq5IPpvtMFR+4yiAO99N06ArbyLh1wkAv7Tt5PWC3JRAXrgC8uJ87vqKSAb2u6tEPY
         Rw5V3L+4E3p+LT27IsuhWc9FZxdX/vkmqPRRo6vJwDYdfqbq5anwfZZYojOTTiC7gg6Q
         /01StxEHLpudYojAqN9Awpt9Sjq/lqYQhkxEynwO1/seVrertuPmhFVelzxMXI2Oswwt
         rNMJbXeZGYiubXFVzfLjp3dpsG8mcW2pZR4nwHglWlB5V1SjvtHDfnJWCgJTSVgrGUDg
         cWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Apgq15pxlwWxLUmTSPSMXlMpS1SiDrgxMaLWg5oKw4=;
        b=ZNdi+gW4iYfrmCASLd2w1RuLYzEgQHGiruQX4xZENm0+IREQ8KN2n0HOZlqkTGEf4C
         kOzQuUXM4c82FXOh7THOuRJUFLp2EBgHVFu67aYy/IW4MDmK21K24dNklZryJ74UFUgx
         zSzbDFP58Cj+2ovHiYLW96zz3vyNau/hskVu8FAFWo3n66r2mQIXqnBMrp2uWb/2SqKH
         ew2EEU3VNsKiusrsOSAVj0dqlQEaoY+1fsjq8zGZlVjMHb/Bu4OZKhSJsLWkTI0Xy4GI
         LhnkSYjqOBAGO2ulTj+LnnY2il5jTicghlwj/8EWnkir4wfgUplymhYhJU6XO0tSwewa
         RlXQ==
X-Gm-Message-State: ANhLgQ3Zoa5imVygLDlMU5KR3kU9WvngUm9+me8/zTAetzFptPxyTJin
        9EPR+gHL7XRrZIBbMY2R/mVoOAMWFldlqm+VFYU=
X-Google-Smtp-Source: ADFU+vsM/ad9CoppWk77tWXmup9wxvqG3Xpslr2wwRxswJPL51yKBUgm7BByb09/mD0bSrCD3Geke+KNH0rwZ5sU6vY=
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr2665750lfg.70.1583944520546;
 Wed, 11 Mar 2020 09:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CrvxZDuRfBvwLV6uJJwtPuj1-vqoELKP3j15k3TbSjyg@mail.gmail.com>
 <20200301100755.4532-1-hdanton@sina.com> <20200309120327.3656-1-hdanton@sina.com>
In-Reply-To: <20200309120327.3656-1-hdanton@sina.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 Mar 2020 13:35:09 -0300
Message-ID: <CAOMZO5B54o=RSKH7-k=cUv5umusgU67XLV9SRNr3AJY-WqKnEA@mail.gmail.com>
Subject: Re: rcu_sched stalls on 4.14
To:     Hillf Danton <hdanton@sina.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf and Paul,

On Mon, Mar 9, 2020 at 9:03 AM Hillf Danton <hdanton@sina.com> wrote:

> Hi Fabio, two minutes to take a look at the softirq part in the syzbot report
> BUG: soft lockup in sys_exit_group.
>
> https://lore.kernel.org/lkml/s5h8sk9svdd.wl-tiwai@suse.de/T/#m0402638ecd30cf5a3c8bb44f03952ccad7a041d8

A different user reported the same bug and it turns out it was an USB
CDC ACM related issue:
https://www.spinics.net/lists/linux-usb/msg192162.html

Thanks for your help!

Fabio Estevam
