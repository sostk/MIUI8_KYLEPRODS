.class public Lcom/android/internal/telephony/util/BlacklistUtils;
.super Ljava/lang/Object;
.source "BlacklistUtils.java"


# static fields
.field public static final BLOCK_CALLS:I = 0x1

.field public static final BLOCK_MESSAGES:I = 0x10

.field private static final DEBUG:Z = false

.field public static final MATCH_LIST:I = 0x3

.field public static final MATCH_NONE:I = 0x0

.field public static final MATCH_PRIVATE:I = 0x1

.field public static final MATCH_REGEX:I = 0x4

.field public static final MATCH_UNKNOWN:I = 0x2

.field private static final TAG:Ljava/lang/String; = "BlacklistUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addOrUpdate(Landroid/content/Context;Ljava/lang/String;II)Z
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "flags"    # I
    .param p3, "valid"    # I

    .prologue
    const/4 v7, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    .local v1, "cv":Landroid/content/ContentValues;
    and-int/lit8 v3, p3, 0x1

    if-eqz v3, :cond_0

    const-string v6, "phone"

    and-int/lit8 v3, p2, 0x1

    if-eqz v3, :cond_2

    move v3, v4

    :goto_0
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v6, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    :cond_0
    and-int/lit8 v3, p3, 0x10

    if-eqz v3, :cond_1

    const-string v6, "message"

    and-int/lit8 v3, p2, 0x10

    if-eqz v3, :cond_3

    move v3, v4

    :goto_1
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v6, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    :cond_1
    sget-object v3, Landroid/provider/Telephony$Blacklist;->CONTENT_FILTER_BYNUMBER_URI:Landroid/net/Uri;

    invoke-static {v3, p1}, Landroid/net/Uri;->withAppendedPath(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .local v2, "uri":Landroid/net/Uri;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, v2, v1, v7, v7}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .local v0, "count":I
    if-lez v0, :cond_4

    :goto_2
    return v4

    .end local v0    # "count":I
    .end local v2    # "uri":Landroid/net/Uri;
    :cond_2
    move v3, v5

    goto :goto_0

    :cond_3
    move v3, v5

    goto :goto_1

    .restart local v0    # "count":I
    .restart local v2    # "uri":Landroid/net/Uri;
    :cond_4
    move v4, v5

    goto :goto_2
.end method

.method public static isBlacklistEnabled(Landroid/content/Context;)Z
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "phone_blacklist_enabled"

    const/4 v4, -0x3

    invoke-static {v2, v3, v0, v4}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v2

    if-eqz v2, :cond_0

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method public static isBlacklistNotifyEnabled(Landroid/content/Context;)Z
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "phone_blacklist_notify_enabled"

    const/4 v4, -0x3

    invoke-static {v2, v3, v0, v4}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v2

    if-eqz v2, :cond_0

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method public static isBlacklistPrivateNumberEnabled(Landroid/content/Context;I)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "mode"    # I

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "phone_blacklist_private_number_enabled"

    const/4 v3, -0x3

    invoke-static {v1, v2, v0, v3}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v1

    and-int/2addr v1, p1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public static isBlacklistRegexEnabled(Landroid/content/Context;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "phone_blacklist_regex_enabled"

    const/4 v3, -0x3

    invoke-static {v1, v2, v0, v3}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public static isBlacklistUnknownNumberEnabled(Landroid/content/Context;I)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "mode"    # I

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "phone_blacklist_unknown_number_enabled"

    const/4 v3, -0x3

    invoke-static {v1, v2, v0, v3}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v1

    and-int/2addr v1, p1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public static isInputRegex(Ljava/lang/String;)Z
    .locals 3
    .param p0, "input"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    const/16 v2, 0x25

    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    if-gez v2, :cond_0

    const/16 v2, 0x5f

    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    if-ltz v2, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v1

    goto :goto_0
.end method

.method public static isListed(Landroid/content/Context;Ljava/lang/String;I)I
    .locals 18
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "mode"    # I

    .prologue
    invoke-static/range {p0 .. p0}, Lcom/android/internal/telephony/util/BlacklistUtils;->isBlacklistEnabled(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v2, 0x0

    return v2

    :cond_0
    const/4 v2, 0x1

    move/from16 v0, p2

    if-ne v0, v2, :cond_2

    const-string v16, "phone"

    .local v16, "type":Ljava/lang/String;
    :goto_0
    move-object/from16 v0, p0

    move/from16 v1, p2

    invoke-static {v0, v1}, Lcom/android/internal/telephony/util/BlacklistUtils;->isBlacklistUnknownNumberEnabled(Landroid/content/Context;I)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static/range {p0 .. p1}, Lcom/android/internal/telephony/CallerInfo;->getCallerInfo(Landroid/content/Context;Ljava/lang/String;)Lcom/android/internal/telephony/CallerInfo;

    move-result-object v11

    .local v11, "ci":Lcom/android/internal/telephony/CallerInfo;
    if-eqz v11, :cond_4

    iget-boolean v2, v11, Lcom/android/internal/telephony/CallerInfo;->contactExists:Z

    if-eqz v2, :cond_4

    .end local v11    # "ci":Lcom/android/internal/telephony/CallerInfo;
    :cond_1
    invoke-static/range {p1 .. p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_6

    move-object/from16 v0, p0

    move/from16 v1, p2

    invoke-static {v0, v1}, Lcom/android/internal/telephony/util/BlacklistUtils;->isBlacklistPrivateNumberEnabled(Landroid/content/Context;I)Z

    move-result v2

    if-eqz v2, :cond_5

    const/4 v2, 0x1

    return v2

    .end local v16    # "type":Ljava/lang/String;
    :cond_2
    const/16 v2, 0x10

    move/from16 v0, p2

    if-ne v0, v2, :cond_3

    const-string v16, "message"

    .restart local v16    # "type":Ljava/lang/String;
    goto :goto_0

    .end local v16    # "type":Ljava/lang/String;
    :cond_3
    const-string v2, "BlacklistUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid mode "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, p2

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x0

    return v2

    .restart local v11    # "ci":Lcom/android/internal/telephony/CallerInfo;
    .restart local v16    # "type":Ljava/lang/String;
    :cond_4
    const/4 v2, 0x2

    return v2

    .end local v11    # "ci":Lcom/android/internal/telephony/CallerInfo;
    :cond_5
    const/4 v2, 0x0

    return v2

    :cond_6
    sget-object v2, Landroid/provider/Telephony$Blacklist;->CONTENT_FILTER_BYNUMBER_URI:Landroid/net/Uri;

    invoke-virtual {v2}, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;

    move-result-object v9

    .local v9, "builder":Landroid/net/Uri$Builder;
    move-object/from16 v0, p1

    invoke-virtual {v9, v0}, Landroid/net/Uri$Builder;->appendPath(Ljava/lang/String;)Landroid/net/Uri$Builder;

    invoke-static/range {p0 .. p0}, Lcom/android/internal/telephony/util/BlacklistUtils;->isBlacklistRegexEnabled(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_7

    const-string v2, "regex"

    const-string v3, "1"

    invoke-virtual {v9, v2, v3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    :cond_7
    const/4 v15, 0x0

    .local v15, "result":I
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v9}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v3

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/String;

    const-string v5, "is_regex"

    const/4 v6, 0x0

    aput-object v5, v4, v6

    const/4 v5, 0x1

    aput-object v16, v4, v5

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v10

    .local v10, "c":Landroid/database/Cursor;
    if-eqz v10, :cond_b

    const-string v2, "is_regex"

    invoke-interface {v10, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v14

    .local v14, "regexColumnIndex":I
    move-object/from16 v0, v16

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v13

    .local v13, "modeColumnIndex":I
    const/16 v17, 0x0

    .local v17, "whitelisted":Z
    const/4 v2, -0x1

    invoke-interface {v10, v2}, Landroid/database/Cursor;->moveToPosition(I)Z

    :cond_8
    :goto_1
    invoke-interface {v10}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_9

    invoke-interface {v10, v14}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    if-eqz v2, :cond_c

    const/4 v12, 0x1

    .local v12, "isRegex":Z
    :goto_2
    invoke-interface {v10, v13}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    if-eqz v2, :cond_d

    const/4 v8, 0x1

    .local v8, "blocked":Z
    :goto_3
    if-nez v12, :cond_f

    if-eqz v8, :cond_e

    const/16 v17, 0x0

    :goto_4
    const/4 v15, 0x3

    if-eqz v8, :cond_8

    .end local v8    # "blocked":Z
    .end local v12    # "isRegex":Z
    :cond_9
    if-eqz v17, :cond_a

    const/4 v15, 0x0

    :cond_a
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    .end local v13    # "modeColumnIndex":I
    .end local v14    # "regexColumnIndex":I
    .end local v17    # "whitelisted":Z
    :cond_b
    return v15

    .restart local v13    # "modeColumnIndex":I
    .restart local v14    # "regexColumnIndex":I
    .restart local v17    # "whitelisted":Z
    :cond_c
    const/4 v12, 0x0

    .restart local v12    # "isRegex":Z
    goto :goto_2

    :cond_d
    const/4 v8, 0x0

    .restart local v8    # "blocked":Z
    goto :goto_3

    :cond_e
    const/16 v17, 0x1

    goto :goto_4

    :cond_f
    if-eqz v8, :cond_8

    const/4 v15, 0x4

    goto :goto_1
.end method

.method public static isValidBlacklistInput(Landroid/content/Context;Ljava/lang/String;)Landroid/util/Pair;
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "number"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")",
            "Landroid/util/Pair",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    invoke-static {p0, p1}, Lcom/android/internal/telephony/util/BlacklistUtils;->normalizeNumber(Landroid/content/Context;Ljava/lang/String;)Landroid/util/Pair;

    move-result-object v1

    .local v1, "normalizeResult":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/String;Ljava/lang/Boolean;>;"
    iget-object v2, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    .local v2, "normalizedNumber":Ljava/lang/String;
    const/16 v3, 0x25

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-gez v3, :cond_1

    const/16 v3, 0x5f

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-ltz v3, :cond_2

    const/4 v0, 0x1

    .local v0, "isRegex":Z
    :goto_0
    if-nez v0, :cond_0

    iget-object v3, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-eqz v3, :cond_3

    :cond_0
    new-instance v3, Landroid/util/Pair;

    const/4 v4, 0x1

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3

    .end local v0    # "isRegex":Z
    :cond_1
    const/4 v0, 0x1

    .restart local v0    # "isRegex":Z
    goto :goto_0

    .end local v0    # "isRegex":Z
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "isRegex":Z
    goto :goto_0

    :cond_3
    invoke-static {p1}, Lcom/android/internal/telephony/util/BlacklistUtils;->isValidPhoneNumber(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    new-instance v3, Landroid/util/Pair;

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v3
.end method

.method public static isValidPhoneNumber(Ljava/lang/String;)Z
    .locals 3
    .param p0, "address"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .local v0, "count":I
    :goto_0
    if-ge v1, v0, :cond_1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Landroid/telephony/PhoneNumberUtils;->isISODigit(C)Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v2, 0x0

    return v2

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v2, 0x1

    return v2
.end method

.method public static normalizeNumber(Landroid/content/Context;Ljava/lang/String;)Landroid/util/Pair;
    .locals 10
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "number"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            ")",
            "Landroid/util/Pair",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v8, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    .local v5, "len":I
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v5}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v7, "ret":Ljava/lang/StringBuilder;
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v5, :cond_7

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .local v1, "c":C
    const/16 v9, 0xa

    invoke-static {v1, v9}, Ljava/lang/Character;->digit(CI)I

    move-result v2

    .local v2, "digit":I
    const/4 v9, -0x1

    if-eq v2, v9, :cond_1

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    :cond_0
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    const/16 v9, 0x61

    if-lt v1, v9, :cond_3

    const/16 v9, 0x7a

    if-gt v1, v9, :cond_3

    :cond_2
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->convertKeypadLettersToDigits(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "actualNumber":Ljava/lang/String;
    invoke-static {p0, v0}, Lcom/android/internal/telephony/util/BlacklistUtils;->normalizeNumber(Landroid/content/Context;Ljava/lang/String;)Landroid/util/Pair;

    move-result-object v8

    return-object v8

    .end local v0    # "actualNumber":Ljava/lang/String;
    :cond_3
    const/16 v9, 0x41

    if-lt v1, v9, :cond_4

    const/16 v9, 0x5a

    if-le v1, v9, :cond_2

    :cond_4
    if-nez v4, :cond_5

    const/16 v9, 0x2b

    if-ne v1, v9, :cond_5

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_5
    const/16 v9, 0x2a

    if-ne v1, v9, :cond_6

    const/16 v9, 0x25

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_6
    const/16 v9, 0x2e

    if-ne v1, v9, :cond_0

    const/16 v9, 0x5f

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .end local v1    # "c":C
    .end local v2    # "digit":I
    :cond_7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .local v6, "normalizedNumber":Ljava/lang/String;
    invoke-static {p0, v6}, Lcom/android/internal/telephony/util/BlacklistUtils;->toE164Number(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "e164Number":Ljava/lang/String;
    if-eqz v3, :cond_8

    move-object v6, v3

    .end local v6    # "normalizedNumber":Ljava/lang/String;
    :cond_8
    if-eqz v3, :cond_9

    const/4 v8, 0x1

    :cond_9
    invoke-static {v8}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    invoke-static {v6, v8}, Landroid/util/Pair;->create(Ljava/lang/Object;Ljava/lang/Object;)Landroid/util/Pair;

    move-result-object v8

    return-object v8
.end method

.method public static toE164Number(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "src"    # Ljava/lang/String;

    .prologue
    const-string v3, "phone"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/TelephonyManager;

    .local v2, "tm":Landroid/telephony/TelephonyManager;
    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v0

    .local v0, "countryCode":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    iget-object v1, v3, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .local v1, "numberLocale":Ljava/util/Locale;
    :goto_0
    invoke-virtual {v1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    invoke-static {p1, v3}, Landroid/telephony/PhoneNumberUtils;->formatNumberToE164(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    return-object v3

    .end local v1    # "numberLocale":Ljava/util/Locale;
    :cond_0
    new-instance v1, Ljava/util/Locale;

    const-string v3, ""

    invoke-direct {v1, v3, v0}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .restart local v1    # "numberLocale":Ljava/util/Locale;
    goto :goto_0
.end method
