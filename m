Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9283E169B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBXBBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 20:01:38 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34443 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:01:37 -0500
Received: by mail-qt1-f176.google.com with SMTP id l16so5533836qtq.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 17:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=geE21WUpBxQzQVQ/tm6WUyB7aw7f534naxzTS3XIcv0=;
        b=jGJpEda6lopIP0mDT3i7FtSyQ3i6gqRGvIA9MaPXAtj59/jXfXc8AwPdE72fa0U4+y
         lrdobdpZ61vy2gEduRj+HlYMaCBuHmHKxLnUALcURmkJRWhmUiG1gvFSWWtIQPzZ49DJ
         2YzwNIWLLpKVEBDxc3Oo+ea2TiDzuXuqKrurEdRW7HK5HxUdVWt3Cv6lENsIv5/Rr9n6
         tX/f32Zp/qsFhZe1DocUrH+nkPXCwLJk0/T79wKK9/W77YiagWI430Jx4VVL7AEF+b9e
         KWyMl9upimK5JT0V1cbEhDB8eW/HFzK2yQFCVOPPox/CxUmledYa0Wu1mrsGXx3nNmGJ
         zmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=geE21WUpBxQzQVQ/tm6WUyB7aw7f534naxzTS3XIcv0=;
        b=OtuATQ/XblsTjYpAgv5Z80Ta8PFMKUgNn3Nln7VdI4uY4QCF9hvgKUPbCABQwAKybt
         4UDKcPoRALFwC2ib4nIB7RGkILJ1FuL3JtBfwgFIBJMWfQApjCn57Tc+fbzGLbC33FrL
         f9QEJ1eHlG44nx5+b737T3u4Ygn//aocll9SoJHJWXixWCYQXlakuCTxZ4BTGXeHnjFR
         XBHlaflUviFnvJY30rximyKnr1RmoPXvFNcmVFB0yxjqA2kwgyH9DphiD7KnDGOmbsZR
         SnjUHo2VWAxTpRN2lYYNDQsSZbu6Wg1stM3oyPr/7yO5qOfnGviQVUStfxB+Z/e0mNS+
         KPmQ==
X-Gm-Message-State: APjAAAX9aZx+/uwU7b4e1+bZNqZpElqQttawgGEkpfpWuEh+ldTnMhpd
        Fzt5+LPo7RJLZvd6IV+1l6dcEQ==
X-Google-Smtp-Source: APXvYqzHDhibNU/FjhfRNLuBs+K68RGY5OBJ3tRFqPbaKs8ZtyL2ibvIYBw9UDct2gsG48nwEyaGlg==
X-Received: by 2002:aed:2f01:: with SMTP id l1mr44205155qtd.391.1582506095368;
        Sun, 23 Feb 2020 17:01:35 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e2sm5242528qkb.112.2020.02.23.17.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 17:01:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
Date:   Sun, 23 Feb 2020 20:01:33 -0500
Message-Id: <62491094-D13B-4EED-8190-4AA4EB77036B@lca.pw>
References: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, elver@google.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 23, 2020, at 7:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>=20
> It may be a bug under certain conditions, but you don't mention what
> conditions they are.  Reporting it as a general bug is not accurate at
> the very least.

Could we rule out load tearing, store tearing and reload of global_req in cp=
uidle_governor_latency() for all compilers and architectures which could int=
roduce logic bugs?

	int global_req =3D cpu_latency_qos_limit();

	if (device_req > global_req)
		device_req =3D global_req;

If under register pressure, the compiler might get ride of the tmp variable,=
 i.e.,

If (device_req > cpu_latency_qos_limit())
=E2=80=94-> race with the writer.
         device_req =3D cpu_latency_qos_limit();


