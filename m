Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3210D927
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK2RuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 12:50:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38788 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2RuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:50:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so6968794lfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 09:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Q7B1pOOucHBt87huxZBlRaeAfEu9kbB/mpRD5aQycvOlNGH6TplJuHQsRKJH4qH0UN
         yWIKcAwhF//MFVM4/s4zo/x7KtobSF+Pbd54HCT2GwMZTMudeBTQLG365XOvOoIzblrG
         5T0K9Po5PikQjYWKuzeRBtyiuqfdx5YrKRXmXnfimNY+4UG7y92c6nzcLuQMFJ9VyBXw
         piRUxmIEwTUVmmIqAh+u/UF/H/S9SDOlUARBYvTSZD2is4I9ZsBeW7vgcIKhIcZtTVVX
         4UTbLrXcJVaEQbWSCYfCNvcNVb62gcRaEQfDuqepjlqffCgNeFQXz4XdXrYshY3ef5bN
         3BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EUMXLSP3Ey/TVSkNKq7Iaslr73dyyp/WEfNwWS7+74G/c2zogXyWuk9nE8lVuifkOY
         SwHtDzszv5WHvDFmOBv91jYlHKo0xqZeyBCVVLVYSyAQoF7w37VV+ZF6WRu8Komouqbj
         rEL9I8gZf2MG6dslMI0Py3JNl6NaIyzoCH0G37eFhJco2JpcFEo1sh3AqaRNgpRNJ6Dg
         W3KIjJuuoukYPFeFsEWf8KO6rB48RYQvXA1incmCQqsi0OufFI3HT+Bt/FClB33yfaoB
         ugBplz3E3IpvjFOlEjqm2ak0AB4WKQyfDVzna8J+aAJJRWJgtzBzG61PHy7vJdf/bCvG
         v7qw==
X-Gm-Message-State: APjAAAUC64WIEyiYCP+I82ciWs3KNIjTi/sKTSgmZ6pMbtAP4QYh8zxF
        STK2mUniO0L8jXrMRZvQIIsBxUQW1yFAv0TCCY8=
X-Google-Smtp-Source: APXvYqwuHQVhvXE3Rmn9Rke4XeTA4CAM0KSo4zk5cknqNS9x0TEWrT5R5gVRvICzIUVKlqgDl3BkCCqELE/H+XBwkZQ=
X-Received: by 2002:ac2:4adc:: with SMTP id m28mr12689852lfp.26.1575049798083;
 Fri, 29 Nov 2019 09:49:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:a0c7:0:0:0:0:0 with HTTP; Fri, 29 Nov 2019 09:49:57
 -0800 (PST)
Reply-To: marianaduran86@hotmail.com
From:   Mariana Duran <andrewroger36@gmail.com>
Date:   Fri, 29 Nov 2019 17:49:57 +0000
Message-ID: <CANRNauF5kJNTNQbP4AqjHLRUAffpCw0yt4F37yq4s-zAmGDiuA@mail.gmail.com>
Subject: =?UTF-8?B?6K+35Zue5aSN5oiR?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


