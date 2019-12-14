Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2A11F2D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLNQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 11:40:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54830 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfLNQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 11:40:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so2024802wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=S9ef2wu9QYXVmSGoompV4V/CxRyXNOIMVXBHA4K/f9o+v26ki0yyDoBwyTFfffCQea
         iKcOo1hMw2Mm46X3Mp5lIJxl16XG+/4uhEBrqNA8xcwBIT62TB0pC3DhuB7Nu/t3Lvdx
         lwGnGK/82sSKn44vm0XTsk9QCfouWLfylL0LXN1mqm+MHilr6YAGSzogO8U4BKWHHOem
         +ZlhuPeThAmie1pW/XmQlzN0VMacCbZMZTP31WZHIE5VmWlIqspY/Gii2htO+7mVE4Xj
         kFO3UM+J7UBFMCbOUdJcdLRUivFUNK+nPzWDk1dMaBXZZHRboaE08zX8paJO7r5fF4ZD
         OjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Hb73Dx8FtHXDNaggXvonm3ClLR1uPKkle8RV0Z3h8IknCFiW2lsxC4YUTCSYdIIJIV
         AM3SkueG9GdAjSs7N4ZWlp11hxXKhIuLcLkKgoPnTmsmC1pjYNDyNBDzPHoIxQguXpQb
         rjZ5INzRJ//PRpNwYSzV6CXuvzVFi9hFZf2WZTsmpzOWKCEECiSJ9w+MWhj1KbAY2RHj
         4WueDCrd26HCVaHDE9za7r9/oXcljKgnTJEoDIYJyBKobg/wuUqYUiiBpWejFyMAGeYo
         8WnyWDiXSdEY1zBv6aZGts3QneQwzXr0C2FaMHc/esYQ1PXb/4KOCrQB5ScGp3Ve7i81
         nUyg==
X-Gm-Message-State: APjAAAXHjySkXXAv3ieU2OektrLgJ6H3U/msE/jKgGQGTdyVYMbKYMJs
        a/bGR9QGMrpC3gm4eFiEFwqcwOFTs/lL5U0rya4=
X-Google-Smtp-Source: APXvYqz/ZzS0cbfLvi3mzdN4R/0OkAg9oC2map23emQc6XBoC4CijTZ43jEQhMVxc9Xctvo2huRrdkbccuyuVl9Y9SY=
X-Received: by 2002:a05:600c:507:: with SMTP id i7mr21190050wmc.135.1576341652019;
 Sat, 14 Dec 2019 08:40:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:a387:0:0:0:0:0 with HTTP; Sat, 14 Dec 2019 08:40:51
 -0800 (PST)
Reply-To: ndahpeter1@gmail.com
From:   ndah peter <anitadeerow2@gmail.com>
Date:   Sat, 14 Dec 2019 17:40:51 +0100
Message-ID: <CAL-fvu7+0mGZi+ibm8pdLR7a3HsMbWqqoqxo-MQgCFO1Ed6QMQ@mail.gmail.com>
Subject: =?UTF-8?B?xaHFpWFzdG7DvSB2w61rZW5kLCBkZWp0ZSBtaSB2xJtkxJt0LCBwb2t1ZCBqc3RlIG9iZA==?=
        =?UTF-8?B?csW+ZWxpIGUtbWFpbCwga3RlcsO9IGpzZW0gdsOhbSBwb3NsYWwgcMWZZWR0w61tPyBwcm9zw61tIG5h?=
        =?UTF-8?B?cGnFoXRlIG1pIHpwxJt0?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


