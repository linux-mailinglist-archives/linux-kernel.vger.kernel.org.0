Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3562B251E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfEUOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:25:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40559 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:25:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so8682264pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oebd2F37ejNWi5lexy3QmDFw2CbVqFTl/Y0CPklSoNM=;
        b=hWnMd6UrwExFgTU4HSM7G+D/D9I/CRkwkBhCMifCTDadcrF4c/ehjCsGQ895PUn7Rd
         uZ3+gY+9yRWM/PcrkejYmvBsmveHe4Eaup8dDMr4sSRhih9YexFK8qHmGl8Bk4tAA3Yx
         obdAvLuHcm8B/4Y4HUQoeL0mlDDziWWiWbRSWmMiYgC8JI/0aQxKKwQOKLev1tobtM2a
         6QIzUybCAlc3JIjug4mp1YUpx4hjr4Wf52A4dQJ31kAg0Sji26+zMhZ3iJ2++va4FjO/
         fKJQZzhVtDkcvExL0u9+kK2ORXOnD9b9zwYRMvZvSsCj0S1TGoLuEQsEoG5+QushoXEb
         Zn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oebd2F37ejNWi5lexy3QmDFw2CbVqFTl/Y0CPklSoNM=;
        b=YlUpq21+YkPXGKra9C9xWF6st4v0gIiPnwJv3IA6Rbx9CeJzof+p590ljz2EfU5VE8
         yAJe/gg971CNt1oAwNxZ5b6ZDjOhhHah+4uxcX5jOTUaGiutM8VHNddsxji0pAi4XAgd
         eZwacq8eJPzWQdTbay1VXf7nY0cC8MvcF0Zr5mrM9pj8l/VQnbj5VZYxksxQK6HtCUWK
         pHxrXqZ3aVLImlXv9CK3Cs+5Q9jEoIHwaVb7UuZKis89Uydoyw8awiYlBVUjL8WQZ8jf
         QdpBl6ghqd2KWl4/KuZDAf6BTVDg4yvbiaMyIo6By9hmIbEC2QPFRCMvTXZ9Zzk94pII
         cAyA==
X-Gm-Message-State: APjAAAXOWu9skoluh2myL7sbYaG3KljkxZSZrettwfwLiKp8iXoIv5VF
        RnyZMUnM2WMCvsSNi9xA/tzhF8y8/9PqwglL/So=
X-Google-Smtp-Source: APXvYqzams8pZm41hOoVPXT7aEDN3bAuARD1yK7Sk6Ou0q1bgGQK7oI3Udb8twNT0BNND54zxCfbKylUPqV3CbPNdMA=
X-Received: by 2002:aa7:8652:: with SMTP id a18mr85679379pfo.167.1558448704934;
 Tue, 21 May 2019 07:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190521142009.7331-1-TheSven73@gmail.com>
In-Reply-To: <20190521142009.7331-1-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 10:24:50 -0400
Message-ID: <CAGngYiVGWkjZoUncRcZJ5uqd2uqX1SmV-aZcfcGHM==8TZSSRA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fieldbus: core: fix ->poll() annotation
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:20 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> From: Oscar Gomez Fuente <oscargomezf@gmail.com>
>
> ->poll() functions should return __poll_t, but the fieldbus
> core's poll() does not. This generates a sparse warning.
>
> Fix the ->poll() return value, and use recommended __poll_t
> constants (EPOLLxxx).
>
> Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>

Please ignore this patch.
> /dev/null :)
