Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC68E7801
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404273AbfJ1SBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 14:01:06 -0400
Received: from mout.web.de ([212.227.17.12]:58237 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404245AbfJ1SBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572285651;
        bh=ClXnfu9SrUz/iZuABru8LxcgIwo6AKmyyfdV4DFEU3Q=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=mn+B/DZGNQsRZHhEhpcuOKLSY3JW8zyaS1HcgPg+zw4MWpeUJfY7TiWx24uEPt4sH
         yZVnKl203Ez7fJa24TmfFi+ThwY1jhltJcrLKE73ocRhFxU5QCE2vSv3WCDOLNddzN
         dv5rEeTIW5rPgHN0+ApEanP4V//575d19qF8f3Fs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.155.234]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilJB-1hqtyA19Uj-00d00Z; Mon, 28
 Oct 2019 19:00:51 +0100
Subject: Re: drm/tinydrm: Fix memory leak in hx8357d_probe
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20191027173234.6449-1-navid.emamdoost@gmail.com>
 <85cb5ed9-66ba-3461-dd56-017b89ba70ce@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4deb2230-eabe-b817-8516-3dfad68d2065@web.de>
Date:   Mon, 28 Oct 2019 19:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <85cb5ed9-66ba-3461-dd56-017b89ba70ce@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ytc3HX3oavOKQ23AqqChQpyeACjYRhzo1t5xewgBgfQXi7C6O66
 FAlqR6CuaCWePGRJJXs6Pru3JqpHhOz2i9Fpov8G2hBYZTOfngFOdqpyGGeC1uKOz7SrPVE
 2BFRe4IU+oiBExtikJXVTJyozkesc5Sg0tA6EpMcl8bD1gqL2+oeqzbeRzuf38vIO6s11QB
 gA5iOAPXmEKRmzweyfTUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n0sTILtGm7w=:blCiOjqDpeGV+//1gSOgcY
 nYr8BXLqX4vJsYy9H9axkiB5vTHnk46+JcQDo/7lqqxONbVf4mL9gfmPi5VdDuHTZjjv38q/U
 7LfcsyQ/GRgD/eCJpkI8M2Mcfa9nS5S7H9mbIcJLMXXrUR/ae4tXvQzc1NBDHmA4nESQN56ee
 9yRyUZITx28uuCZeuAaDyvgtoZIu+SnEtrxGSEhvd8fQxsJtwIizxHTthw/8MBrXbOmPRi7+v
 UNO5ex5On8y4FEkGdWQCpt/uy50NxaQZePUTnIFeqF53HTNmT4Iqg8IMG9F2Lhbaned7bHnAK
 9jfFQtAQsXxxnVpbVs/9vWPuJaz54hJtwVIPmswqVJj3464PgTNNJfFHJE1UYC8WsXG6KYbx0
 r9IiHmKpBOZV+HmWmeLMkduRYwuutTqVnrfBhF4gKiqw/xg8OJ1JUmIWMp7U1EaavXfVScets
 6GI1yHszhhnipm/A1tGt240jQEXwiKaN2QJ4XLq05xnyOoVVD4jlFcAGBUuDYUXr1ph59hkXe
 ZrI9X+LvSj3oFITHG4cCDZ4+sMdDBvbNL5y1pXrFG9Xwtr1rJWeLD0oUzI0AJ/6kgoAvh5VHx
 yQ9N3lD6nNaEDXgum2z+GqvqAjbDog32QAWuu7rZHqsvFx3JoTsykbYpnenmpHhsBtqaVkKDV
 jkI3azagDzwrtmfDPXtFOEK+Gf+LWb92m5xFL8nP8XaJhpSGvrKiS/PAljW0I3RSF8XoPDGE9
 UUIFEKcAWoe8c2oqfdiuW82LsNaMhp/XNyzSEZ8rODoaz+jGLlaU+LdmF/qsNy2YYxkH1URtW
 TtJaGA4yjAmCUe8Vno1j6qZe91L10DjjXmIcYfR2qkS34u2k/wORDpO8Tb0e4du/k9ZUGpfiN
 389Q2jfr2PTTmzB3TV2LlOE3GxynIslLkr6RkZyoH7vbDG+pZs6dtnFrpG8Z6K13HWrTNmnD3
 qAECvRAkWKiLtBZHJuqwJ78vtAWddzQnqDzVG+vHr9fvCTVCpHGGXsCZ3N0t3sXgJfPffZJNT
 sRGfP9BSnMja0v2cWFIOFMUokfe+b2EwjoOIdVzZY9FyvLz6Wrmvn12SDBgTiym+BqzxIo3lN
 C/cgFlbF7zPESxv2GVXAsPI5xoT1vzSj9LF9nM2kSNiaPAVPNHn6+Ka+IEKxFnzmk3yBP4vNr
 MK82eyoIYxzsFJ+iQ54CqhJbxZXA8SYk9Jj3sb81cOuANCUhc+BUU072knqNdy9sKK5++YztR
 8Ux7FwDR2mpqjCrBtYC3GcrXX2Mz5WI0ydKnv/Kpm46vxR0QIEv/DxWbPgv4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6
>> +free_dbidev:
>> +	kfree(dbidev);
> =E2=80=A6
>
> I became curious if there is a need for such a memory release at another=
 place.

I have taken another look also at a related implementation detail.
Now I have realised that the desired clean-up should usually be achieved b=
y
the callback function =E2=80=9Cmipi_dbi_release=E2=80=9D for this software=
 module.
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/gpu/drm/drm_mipi_=
dbi.c#L581
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/drm_mipi_dbi.c?id=3D0365fb6baeb1ebefbbdad9e3f48bab9b3ccb8df3=
#n581

Regards,
Markus
