Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5911157F87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBJQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 11:16:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41505 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:16:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id d11so7025314qko.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dAJybwrGCLZNtcnQsurUDSEE3vxhzkNctFcgFV8Jq9M=;
        b=XgcoyZnqYnSrDOqE1q5Nf2xd0M5i+D3L3tQMpdUc0aRi31LwXecknf6Ha/KocNG8iS
         QjWJqWrM+EMjrFKr3Khrh0m7nMStcIOC8neBHzJyTByqn6G61jtobx4T2tdHeYvvmfra
         LE9FVqF6QkC7Avh4nzrI37XyLL9ztMynfF8ZVufFcl2umfKaEOUQrFHnj0OnTdZ49OHh
         89xdPSLI6RC7e0J1UjnD4ACka+XYos0gTfr/3mS0GhqtRbIzidMKTlveHhBxz0K60imo
         +PFVu/SZ1o/yC8dy4pTif1tZxVS2r4EBO6rhdEm8q1Nfi8srRvsI1PvhJ+MWCorBqPLH
         Z+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=dAJybwrGCLZNtcnQsurUDSEE3vxhzkNctFcgFV8Jq9M=;
        b=hdqfZ6mV666AFHQsMVnaZgxVwzj6dPAC4bLtCUnIkc72YJibEF9X2R5T4r1pki1EAZ
         G3006Ctwalu2Sb925q+i1BOVlSXUBbUppOJ2Zu2AZFZdChTRKepGRhBmT/waZT52qY8o
         DSQMhH2qwFiIEjInMEwI9E+hZ1xanKnCfPFnZ8G7jIOdgo8tMBF3ShrmhIrFRrn11SRe
         /X22rakTRO+wI37x5KnOjDoDrREi3n6Wm6g8lZCR6+fXdS2BjKr2McB4z0EwAYpxkwfZ
         NPH+5Rm4ey1Tc2dhe6CqmTY5wYO7IT4OSesFYSF5LQVneCgmc3uR2qFKyThDR/U6EjnJ
         rN1Q==
X-Gm-Message-State: APjAAAWRMEp/sO/221fJtW/jVX08jaK8Ccp+z2koCIyHtaJw329rHQO2
        wBHqTLYg7Nk4YWRQVXkgdfRRZx1eq+dlNAvyJJksL0DrlXs=
X-Google-Smtp-Source: APXvYqyg7/5NUx/KddWHUceI2huMiTbVD0/p8PGmEsJyAf+hJiuZGBBMIk//Fe4F7t45BrlO4YwG486Pdud7O2DIZNs=
X-Received: by 2002:a05:620a:1679:: with SMTP id d25mr2023835qko.67.1581351380043;
 Mon, 10 Feb 2020 08:16:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:729:0:0:0:0 with HTTP; Mon, 10 Feb 2020 08:16:19
 -0800 (PST)
Reply-To: amboline.hills@gmail.com
From:   Amboline Hills <centopara@gmail.com>
Date:   Mon, 10 Feb 2020 17:16:19 +0100
Message-ID: <CAH8WxbfuEahCJ3uAWxgVH8vS6ag=kKW2gpkQdUqqh8xw1XMQjQ@mail.gmail.com>
Subject: =?UTF-8?B?44GT44KT44Gr44Gh44Gv?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

44GT44KT44Gr44Gh44GvDQoNCuengeOBruimquaEm+OBquOCi+WPi+S6uuOAgQ0K56eB44Gv5byB
6K235aOr44Gn44GZ44CC44Ki44Oz44Oc44Oq44Oz44O744OS44Or44K644CB5b6M5pyfTXIuSi5C
44Gu5byB6K235aOr44CCDQrnp4Hjga/jgIHjgq/jg6njgqTjgqLjg7Pjg4jjga7mrbvkuqHku6Xm
naXoq4vmsYLjgZXjgozjgabjgYTjgarjgYTpioDooYzjga7poJDph5Hmrovpq5jvvIgxMC4155m+
5LiH57Gz44OJ44Or77yJ44Gu44Gf44KB44CB44GC44Gq44Gf44Gr6YCj57Wh44GX44Gm44GE44G+
44GZ44CC44GZ44GQ44Gr56eB44Gr5oi744Gj44GmDQroqbPntLDjgIINCuOCiOOCjeOBl+OBj+OA
gQ0KQmFyci5BbWJvbGluZSBIaWxscw0K
