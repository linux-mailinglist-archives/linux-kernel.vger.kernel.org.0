Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031987808D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfG1RF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 13:05:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38613 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfG1RF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:05:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so42585261qkk.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HEdlC9jhvfAWmLPF1HcM3JfkRvAnyxbtvE+2A7gsrm8=;
        b=Bwj6vKxdNPUV7Im25k0SnmCS2BG+nm6KEubiUqpLb+JJMuCs+a1R2Cp/7kwgrn0+fV
         4PVxZurvjyQ2xjJQLbG7IMVOMxNkTSAPfkfc+87qwv6nS0twNfoad2dTWCe4q/OevXex
         q0o+Vf3lbBqM0SuzTwEop6bND+MatcNi5JrIvg+jUDTKgJXSLWZZggDmGmoqVM5y38EV
         0dGs5mmyTIYyRE06ijuNEz8WapLl8BipGT8WqVRS8vABah0DstTIAGCKfkFCvFHSKHCY
         l+kS0p3jRtUBx3UBhgNV/gmM8Wrdklsyx81k6fVYoDpVIhgiTtNXnhNxHy1UHp6bIbAq
         E+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HEdlC9jhvfAWmLPF1HcM3JfkRvAnyxbtvE+2A7gsrm8=;
        b=FVKgj7c/9JDert3mW9T0AQHgN+GxDbZksS46OINZ+45ZtSDtPCkVbMqYW83GPvlqEr
         txEf8hVrJrv4R4vDEnE6PeSIWNZ7vMcLkp+wJRRkcw/+j0PABWM5kXO/LZP7ZZkUOnvc
         0s2TtT7Y3gIFuvku/AFFCweqaL3xM6z72PylBSDR0mFR8YtnKP1I+vOrWSHd80BAZ/Nc
         9W1HTkKb89nzzmiLZSABZL9zX+R+ak06w22ennKn+plhwFd6w+hZW2ZuyeqgLw1SfqFz
         tjDvIuiDi/qUt5Flkicobx5M6iKfA3F2tU03w3vm2VxW17c2ifGtX/IyKgUfXNcULqUF
         C9wA==
X-Gm-Message-State: APjAAAWFf0tHQIvabUpnZNQMOMVBoapJoPVx4C/qkuMWi3t8pv0GdClj
        4fHEqEO8hrwNbnKJsnxy7cfw0g==
X-Google-Smtp-Source: APXvYqwypC8SEOFpXhjpOkVi9iLyVfUMsbWECCym+VP9gTSfnWPi1kb4+V5m7fd8n0ODiCrKPaf1zw==
X-Received: by 2002:a05:620a:4d4:: with SMTP id 20mr36523467qks.95.1564333528042;
        Sun, 28 Jul 2019 10:05:28 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x8sm27276208qka.106.2019.07.28.10.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 10:05:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190726213045.GL6204@localhost.localdomain>
Date:   Sun, 28 Jul 2019 13:05:25 -0400
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A42819C-32E5-4869-8A3B-0D4F9DF1B53C@lca.pw>
References: <1564174659-21211-1-git-send-email-cai@lca.pw>
 <20190726213045.GL6204@localhost.localdomain>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 26, 2019, at 5:30 PM, Marcelo Ricardo Leitner =
<marcelo.leitner@gmail.com> wrote:
>=20
> On Fri, Jul 26, 2019 at 04:57:39PM -0400, Qian Cai wrote:
>> There are a lot of those warnings with GCC8+ 64bit,
>>=20
>> In file included from ./include/linux/sctp.h:42,
>>                 from net/core/skbuff.c:47:
>> ./include/uapi/linux/sctp.h:395:1: warning: alignment 4 of 'struct
>> sctp_paddr_change' is less than 8 [-Wpacked-not-aligned]
>> } __attribute__((packed, aligned(4)));
>> ^
>> ./include/uapi/linux/sctp.h:728:1: warning: alignment 4 of 'struct
>> sctp_setpeerprim' is less than 8 [-Wpacked-not-aligned]
>> } __attribute__((packed, aligned(4)));
>> ^
>> ./include/uapi/linux/sctp.h:727:26: warning: 'sspp_addr' offset 4 in
>> 'struct sctp_setpeerprim' isn't aligned to 8 [-Wpacked-not-aligned]
>>  struct sockaddr_storage sspp_addr;
>>                          ^~~~~~~~~
>> ./include/uapi/linux/sctp.h:741:1: warning: alignment 4 of 'struct
>> sctp_prim' is less than 8 [-Wpacked-not-aligned]
>> } __attribute__((packed, aligned(4)));
>> ^
>> ./include/uapi/linux/sctp.h:740:26: warning: 'ssp_addr' offset 4 in
>> 'struct sctp_prim' isn't aligned to 8 [-Wpacked-not-aligned]
>>  struct sockaddr_storage ssp_addr;
>>                          ^~~~~~~~
>> ./include/uapi/linux/sctp.h:792:1: warning: alignment 4 of 'struct
>> sctp_paddrparams' is less than 8 [-Wpacked-not-aligned]
>> } __attribute__((packed, aligned(4)));
>> ^
>> ./include/uapi/linux/sctp.h:784:26: warning: 'spp_address' offset 4 =
in
>> 'struct sctp_paddrparams' isn't aligned to 8 [-Wpacked-not-aligned]
>>  struct sockaddr_storage spp_address;
>>                          ^~~~~~~~~~~
>> ./include/uapi/linux/sctp.h:905:1: warning: alignment 4 of 'struct
>> sctp_paddrinfo' is less than 8 [-Wpacked-not-aligned]
>> } __attribute__((packed, aligned(4)));
>> ^
>> ./include/uapi/linux/sctp.h:899:26: warning: 'spinfo_address' offset =
4
>> in 'struct sctp_paddrinfo' isn't aligned to 8 [-Wpacked-not-aligned]
>>  struct sockaddr_storage spinfo_address;
>>                          ^~~~~~~~~~~~~~
>> Fix them by aligning the structures and fields to 8 bytes instead.
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> include/uapi/linux/sctp.h | 18 +++++++++---------
>> 1 file changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
>> index b8f2c4d56532..e7bd71cde882 100644
>> --- a/include/uapi/linux/sctp.h
>> +++ b/include/uapi/linux/sctp.h
>=20
> These changes gotta be more careful, if possible at all. As is, it's =
breaking UAPI.

Could you please elaborate how this breaks userspace? I read through all =
the information
I can find about UAPI and still have no clue. All I can see if that some =
field alignments changed
which are expected, and it still take on 3 cachelines which should not =
hurt the performance.

>=20
> -before
> +after patch
>=20
> struct sctp_paddrparams {
>        sctp_assoc_t               spp_assoc_id;         /*     0     4 =
*/
> -       struct __kernel_sockaddr_storage spp_address =
__attribute__((__aligned__(1))); /*     4   128 */
> -       /* --- cacheline 2 boundary (128 bytes) was 4 bytes ago --- */
> -       __u32                      spp_hbinterval;       /*   132     =
4 */
> -       __u16                      spp_pathmaxrxt;       /*   136     =
2 */
> -       __u32                      spp_pathmtu;          /*   138     =
4 */
> -       __u32                      spp_sackdelay;        /*   142     =
4 */
> -       __u32                      spp_flags;            /*   146     =
4 */
> -       __u32                      spp_ipv6_flowlabel;   /*   150     =
4 */
> -       __u8                       spp_dscp;             /*   154     =
1 */
>=20
> -       /* size: 156, cachelines: 3, members: 9 */
> +       /* XXX 4 bytes hole, try to pack */
> +
> +       struct __kernel_sockaddr_storage spp_address =
__attribute__((__aligned__(8))); /*     8   128 */
> +       /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> +       __u32                      spp_hbinterval;       /*   136     =
4 */
> +       __u16                      spp_pathmaxrxt;       /*   140     =
2 */
> +       __u32                      spp_pathmtu;          /*   142     =
4 */
> +       __u32                      spp_sackdelay;        /*   146     =
4 */
> +       __u32                      spp_flags;            /*   150     =
4 */
> +       __u32                      spp_ipv6_flowlabel;   /*   154     =
4 */
> +       __u8                       spp_dscp;             /*   158     =
1 */
> +
> +       /* size: 160, cachelines: 3, members: 9 */
> +       /* sum members: 155, holes: 1, sum holes: 4 */
>        /* padding: 1 */
> -       /* forced alignments: 1 */
> -       /* last cacheline: 28 bytes */
> -} __attribute__((__aligned__(4)));
> +       /* forced alignments: 1, forced holes: 1, sum forced holes: 4 =
*/
> +       /* last cacheline: 32 bytes */
> +} __attribute__((__aligned__(8)));
>=20
>=20
>> @@ -392,7 +392,7 @@ struct sctp_paddr_change {
>> 	int spc_state;
>> 	int spc_error;
>> 	sctp_assoc_t spc_assoc_id;
>> -} __attribute__((packed, aligned(4)));
>> +} __attribute__((packed, aligned(8)));
>>=20
>> /*
>>  *    spc_state:  32 bits (signed integer)
>> @@ -724,8 +724,8 @@ struct sctp_assocparams {
>>  */
>> struct sctp_setpeerprim {
>> 	sctp_assoc_t            sspp_assoc_id;
>> -	struct sockaddr_storage sspp_addr;
>> -} __attribute__((packed, aligned(4)));
>> +	struct sockaddr_storage sspp_addr __attribute__((aligned(8)));
>> +} __attribute__((packed, aligned(8)));
>>=20
>> /*
>>  * 7.1.10 Set Primary Address (SCTP_PRIMARY_ADDR)
>> @@ -737,8 +737,8 @@ struct sctp_setpeerprim {
>>  */
>> struct sctp_prim {
>> 	sctp_assoc_t            ssp_assoc_id;
>> -	struct sockaddr_storage ssp_addr;
>> -} __attribute__((packed, aligned(4)));
>> +	struct sockaddr_storage ssp_addr __attribute__((aligned(8)));
>> +} __attribute__((packed, aligned(8)));
>>=20
>> /* For backward compatibility use, define the old name too */
>> #define sctp_setprim	sctp_prim
>> @@ -781,7 +781,7 @@ enum  sctp_spp_flags {
>>=20
>> struct sctp_paddrparams {
>> 	sctp_assoc_t		spp_assoc_id;
>> -	struct sockaddr_storage	spp_address;
>> +	struct sockaddr_storage	spp_address __attribute__((aligned(8)));
>> 	__u32			spp_hbinterval;
>> 	__u16			spp_pathmaxrxt;
>> 	__u32			spp_pathmtu;
>> @@ -789,7 +789,7 @@ struct sctp_paddrparams {
>> 	__u32			spp_flags;
>> 	__u32			spp_ipv6_flowlabel;
>> 	__u8			spp_dscp;
>> -} __attribute__((packed, aligned(4)));
>> +} __attribute__((packed, aligned(8)));
>>=20
>> /*
>>  * 7.1.18.  Add a chunk that must be authenticated (SCTP_AUTH_CHUNK)
>> @@ -896,13 +896,13 @@ struct sctp_stream_value {
>>  */
>> struct sctp_paddrinfo {
>> 	sctp_assoc_t		spinfo_assoc_id;
>> -	struct sockaddr_storage	spinfo_address;
>> +	struct sockaddr_storage	spinfo_address =
__attribute__((aligned(8)));
>> 	__s32			spinfo_state;
>> 	__u32			spinfo_cwnd;
>> 	__u32			spinfo_srtt;
>> 	__u32			spinfo_rto;
>> 	__u32			spinfo_mtu;
>> -} __attribute__((packed, aligned(4)));
>> +} __attribute__((packed, aligned(8)));
>>=20
>> /* Peer addresses's state. */
>> /* UNKNOWN: Peer address passed by the upper layer in sendmsg or =
connect[x]
>> --=20
>> 1.8.3.1

